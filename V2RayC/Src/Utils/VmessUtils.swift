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
    let vmessBase64String = url.sub
}
