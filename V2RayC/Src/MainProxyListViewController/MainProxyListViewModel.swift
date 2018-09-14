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
    var proxyItems = [ProxyModel]()
    var subscribeURLs = [String]()

    func mockData() {
    }

    // MARK: - Public Methods
    func fetchSubscibeFrom(url: String, complete: @escaping () -> Void) -> Void {
        Alamofire.request(url).responseJSON { [weak self] response in
            if let ss = self {
                if let resp = response.response, resp.statusCode == 200 {
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        ss.handleSubscribeInfo(infoString: utf8Text)
                        complete()
                    }
                }
            }
        }
    }
    
    func saveToDisk() {
        for model in proxyItems {
            model.saveToDisk()
        }
        UserDefaults.standard.set(subscribeURLs, forKey: "subscribeURLs")
    }
    
    func loadFromDisk() {
        var models = [ProxyModel]()
        let fm = FileManager.default
        if let items = try? fm.contentsOfDirectory(atPath: kV2rayConfigFolderPath) {
            for item in items {
                if item.hasSuffix(".json") {
                    if let context = try? String(contentsOfFile: "\(kV2rayConfigFolderPath)/\(item)", encoding: String.Encoding.utf8) {
                        if let model = ProxyModel(JSONString: context) {
                            models.append(model)
                        }
                    }
                }
                
            }
        }
        proxyItems = models
        if let arr = UserDefaults.standard.object(forKey: "subscribeURLs") as? [String] {
            subscribeURLs = arr
        }
    }

    // MARK: - Private Methods
    func handleSubscribeInfo(infoString: String) {
        if let decodeData = Data(base64Encoded: infoString), let decodeString = String(data: decodeData, encoding: String.Encoding.utf8) {
            let vmessList = decodeString.components(separatedBy: "\r\n")
            for vmessUrl in vmessList {
                if let model = genProxyModelFrom(url: vmessUrl) {
                    proxyItems.insert(model, at: 0)
                }
            }
        }
    }
}
