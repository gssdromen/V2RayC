//
//  ProxyModel.swift
//  V2RayC
//
//  Created by cedric on 2018/8/25.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa
import ObjectMapper

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
    case auto = "auto"
}

enum ProxyNetwork: String {
    case tcp = "tcp"
    case kcp = "kcp"
    case ws = "ws"
    case http2 = "http2"
}

class ProxyModel: NSObject, Mappable {
    /// 惟一ID
    var pid: String?
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
    var alterID: Int?
    /// 安全加密方法
    var security: ProxySecurity?
    /// 网络
    var network: ProxyNetwork?
    /// 是否启用tls
    var tls: Bool?
    /// 如果配置来自文件, 这个字符串存了配置文件的地址
    var configPath: String?
    /// 混淆用的host
    var host: String?
    // 混淆用的path
    var path: String?
    // 是否被选中
    var isSelected: Bool = false

    // MARK: - Public Methods
    func saveToDisk() {
        if let jsonString = toJSONString() {
            let path = "\(kV2rayConfigFolderPath)\(remarks ?? "default").json"
            try? (jsonString as NSString).write(toFile: path, atomically: false, encoding: String.Encoding.utf8.rawValue)
        }
    }

    func deleteFromDisk() {
        let path = "\(kV2rayConfigFolderPath)\(remarks ?? "default").json"
        try? FileManager.default.removeItem(atPath: path)
    }

    // MARK: - Mappable
    required init?(map: Map) { }
    override init() {
    }

    func mapping(map: Map) {
        from <- map["from"]
        address <- map["address"]
        port <- map["port"]
        remarks <- map["remarks"]
        id <- map["id"]
        alterID <- map["alterID"]
        security <- map["security"]
        network <- map["network"]
        tls <- map["tls"]
        configPath <- map["configPath"]
        host <- map["host"]
        path <- map["path"]
    }

    // MARK: - Life Cycle
    convenience init(dict: [String: AnyObject]) {
        self.init()
        if let ps = dict["ps"] {
            if let ps = ps as? String {
                remarks = ps
            }
        }
        if let add = dict["add"] {
            if let add = add as? String {
                address = add
            }
        }
        if let p = dict["port"] {
            if let p = p as? String {
                port = Int(p)
            } else if let p = p as? Int64 {
                port = Int(p)
            }
        }
        if let idd = dict["id"] {
            if let idd = idd as? String {
                id = idd
            }
        }
        if let aid = dict["aid"] {
            if let aid = aid as? String {
                alterID = Int(aid)
            }
        }
        if let net = dict["net"] {
            if let net = net as? String {
                switch net {
                case "tcp":
                    network = ProxyNetwork.tcp
                    break
                case "kcp":
                    network = ProxyNetwork.kcp
                    break
                case "ws":
                    network = ProxyNetwork.ws
                    break
                case "h2":
                    network = ProxyNetwork.http2
                    break
                default:
                    network = ProxyNetwork.tcp
                    break
                }
            }
        }
        if let t = dict["tls"] {
            if let t = t as? String {
                tls = t == "tls"
            }
        }
        if let sec = dict["type"] {
            if let sec = sec as? String {
                switch sec {
                case "chacha20-poly1305":
                    security = ProxySecurity.chacha20poly1305
                    break
                case "aes-128-cfb":
                    security = ProxySecurity.aes128cfb
                    break
                case "aes-128-gcm":
                    security = ProxySecurity.aes128gcm
                    break
                case "none":
                    security = ProxySecurity.none
                    break
                default:
                    security = ProxySecurity.none
                    break
                }
            }
        }
        if let h = dict["host"] {
            if let h = h as? String {
                host = h
            }
        }
        if let p = dict["path"] {
            if let p = p as? String {
                path = p
            }
        }
    }
}
