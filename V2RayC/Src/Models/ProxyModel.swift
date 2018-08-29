//
//  ProxyModel.swift
//  V2RayC
//
//  Created by cedric on 2018/8/25.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa

enum ProxyFrom: Int {
    /// 从UI设置的, 最普通的
    case normal = 0

    /// 从配置文件导入的
    case custom = 1

    /// 从订阅来的
    case subscribtion = 2
}

enum ProxySecurity: String {
    case chacha20poly1305 = "chacha20-poly1305"
    case aes128cfb = "aes-128-cfb"
    case aes128gcm = "aes-128-gcm"
    case none = "none"
}

enum ProxyNetwork: String {
    case tcp = "tcp"
    case kcp = "kcp"
    case ws = "ws"
    case http2 = "http2"
}

class ProxyModel: NSObject {
    /// 配置来自
    var from: ProxyFrom?
    /// 地址
    var address: String?
    /// 端口
    var port: Int?
    /// 备注
    var remarks: String?
    /// ID
    var id: String?
    /// 额外ID
    var alterID: String?
    /// 安全加密方法
    var security: ProxySecurity?
    /// 网络
    var network: ProxyNetwork?
    /// 是否启用tls
    var tls: Bool?
}
