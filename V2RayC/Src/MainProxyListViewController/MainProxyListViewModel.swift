//
//  MainProxyListViewModel.swift
//  V2RayC
//
//  Created by cedric on 2018/8/25.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa
import ObjectMapper
import Alamofire

class MainProxyListViewModel: NSObject {
//    var proxyItems = [ProxyModel]()
//    var subscribeURLs = [String]()

    // MARK: - Public Methods
//    func clearAllSubscibe() {
//        proxyItems = proxyItems.filter { (proxyModel) -> Bool in
//            return proxyModel.from != ProxyFrom.subscribtion
//        }
//    }
//    
//    func fetchFromSubscribe(complete: @escaping () -> Void) {
//        for (_, url) in subscribeURLs.enumerated() {
//            fetchSubscibeFrom(url: url, complete: {
//                complete()
//            })
//        }
//    }

    // MARK: - Private Methods
//    private func fetchSubscibeFrom(url: String, complete: (() -> Void)?) -> Void {
//        Alamofire.request(url).responseJSON { [weak self] response in
//            if let ss = self {
//                if let resp = response.response, resp.statusCode == 200 {
//                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                        ss.handleSubscribeInfo(infoString: utf8Text)
//                        complete?()
//                    }
//                }
//            }
//        }
//    }
//
//    private func handleSubscribeInfo(infoString: String) {
//        if let decodeData = Data(base64Encoded: infoString), let decodeString = String(data: decodeData, encoding: String.Encoding.utf8) {
//            let vmessList = decodeString.components(separatedBy: "\r\n")
//            for vmessUrl in vmessList {
//                if let model = genProxyModelFrom(url: vmessUrl) {
//                    proxyItems.insert(model, at: 0)
//                }
//            }
//        }
//    }
}
