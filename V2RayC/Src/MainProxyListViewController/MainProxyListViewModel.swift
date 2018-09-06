//
//  MainProxyListViewModel.swift
//  V2RayC
//
//  Created by cedric on 2018/8/25.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa
import Alamofire

class MainProxyListViewModel: NSObject {
    var proxyItems = [ProxyModel]()

    func mockData() {
        let model1 = ProxyModel()
        model1.remarks = "test1"
        model1.configPath = "/Users/cedricwu/Tools/v2ray/config_dsp2.json"
        model1.from = ProxyFrom.custom

        let model2 = ProxyModel()
        model2.remarks = "test2"
        model2.address = "33.21.23.55"
        model2.port = 92
        model2.from = ProxyFrom.normal

        proxyItems.append(model1)
        proxyItems.append(model2)
    }

    // MARK: - Public Methods
    func fetchSubscibeFrom(url: String) -> Void {
        Alamofire.request(url).responseJSON { [weak self] response in
            if let ss = self {
                if let resp = response.response, resp.statusCode == 200 {
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        ss.handleSubscribeInfo(infoString: utf8Text)
                    }
                }
            }
        }
    }

    // MARK: - Private Methods
    func handleSubscribeInfo(infoString: String) {
        if let decodeData = Data(base64Encoded: infoString), let decodeString = String(data: decodeData, encoding: String.Encoding.utf8) {
            let vmessList = decodeString.components(separatedBy: "\r\n")
            
        }
    }
}
