//
//  VmessUtils.swift
//  V2RayC
//
//  Created by cedric on 2018/9/6.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Foundation

func genProxyModelFrom(url: String) -> ProxyModel? {
    guard url.hasPrefix("vmess://") else {
        return nil
    }
    
    let vmessBase64String = String(url[url.index(url.startIndex, offsetBy: 8)...])
    if let date  = Data(base64Encoded: vmessBase64String), let vmessJsonString = String(data: date, encoding: String.Encoding.utf8) {
        
        if let dict = convertStringToDictionary(text: vmessJsonString) as? [String: String] {
            let model = ProxyModel(dict: dict)
            model.from = ProxyFrom.subscribtion
            return model
        }
    }
    return nil
}
