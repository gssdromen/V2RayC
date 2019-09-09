//
//  VmessUtils.swift
//  V2RayC
//
//  Created by cedric on 2018/9/6.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Foundation

func genProxyModelFrom(vmessURL: String) -> ProxyModel? {
    guard vmessURL.hasPrefix("vmess://") else {
        return nil
    }

    var vmessBase64String = String(vmessURL[vmessURL.index(vmessURL.startIndex, offsetBy: 8)...])
    if let date = Data(base64Encoded: vmessBase64String), let vmessJsonString = String(data: date, encoding: String.Encoding.utf8) {

        if let dict = convertStringToDictionary(text: vmessJsonString) {
            let model = ProxyModel(dict: dict)
            model.from = ProxyFrom.subscribtion
            return model
        }
    }
    return nil
}

func fetchProxyModelsFrom(url: String) {
    _ = fetchSubscribeContentFrom(url: url).drive(onNext: { (content) in
        if handleSubscribeInfoType1(contentString: content) {
            
        }
        if handleSubscribeInfoType2(contentString: content) {
            
        }
    }, onCompleted: {
            NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: kSubscribeRefreshComplete)))
        }, onDisposed: {

        })
}

/// 处理订阅来的Proxy, Type1: 先base64解码，里面是vmess://开头的链接
///
/// - Parameter contentString: 从订阅网址得到的字符串
private func handleSubscribeInfoType1(contentString: String) -> Bool {
    var proxyModels = [ProxyModel]()
    if let decodeData = Data(base64Encoded: contentString), let decodeString = String(data: decodeData, encoding: String.Encoding.utf8) {
        let vmessList = decodeString.components(separatedBy: "\r\n")
        for vmessUrl in vmessList {
            if let model = genProxyModelFrom(vmessURL: vmessUrl) {
                proxyModels.append(model)
            }
        }
    }
    if proxyModels.count > 0 {
        ProxyListManager.shared.addProxy(list: proxyModels, at: nil)
        return true
    } else {
        return false
    }
}

/// 处理订阅来的Proxy, Type1: 先base64解码，里面是vmess://开头的链接
///
/// - Parameter contentString: 从订阅网址得到的字符串
private func handleSubscribeInfoType2(contentString: String) -> Bool {
    var proxyModels = [ProxyModel]()
    if let decodeData = Data(base64Encoded: contentString), let decodeString = String(data: decodeData, encoding: String.Encoding.utf8) {
        let vmessList = decodeString.components(separatedBy: "\n")
        for vmessUrl in vmessList {
            if let model = genProxyModelFrom(vmessURL: vmessUrl) {
                proxyModels.append(model)
            }
        }
    }
    if proxyModels.count > 0 {
        ProxyListManager.shared.addProxy(list: proxyModels, at: nil)
        return true
    } else {
        return false
    }
}
