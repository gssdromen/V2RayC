//
//  ProxyListManager.swift
//  V2RayC
//
//  Created by cedricwu on 2019/1/31.
//  Copyright © 2019 cedric. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProxyListManager {
    // MARK: - Singleton
    static let shared = ProxyListManager()

    // MARK: - Variables
    public private(set) var proxyModels = [ProxyModel]()
    public private(set) var subscribeURLs = [String]()

    // MARK: - Public Methods
    // MARK: 保存 读取 相关
    public func saveToDisk() {
        for model in proxyModels {
            model.saveToDisk()
        }
        UserDefaults.standard.set(subscribeURLs, forKey: kSubscribeURLUserDefaultsKey)
    }

    public func loadFromDisk() {
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
        if models.count > 0 {
            proxyModels = models
        }
    }

    // MARK: - Public Methods
    // MARK: 启动 停止 相关
    public func getCurrentProxyModel() -> ProxyModel? {
        return nil
    }

    public func startProxy(index: Int) {
        if index < proxyModels.count {

        }
    }

    public func stopAllProxy() {

    }

    // MARK: - Public Methods
    // MARK: 添加 删除 相关

    /// 新增代理
    ///
    /// - Parameters:
    ///   - list: 代理列表
    ///   - at: 添加在哪个index，不传默认添加在最后，超出范围也添加在最后
    public func addProxy(list: [ProxyModel], at: Int?) {
        if at == nil {
            proxyModels.append(contentsOf: list)
        }
        if at! >= proxyModels.count {
            proxyModels.append(contentsOf: list)
        }
        for model in list {
            proxyModels.insert(model, at: at!)
        }
        saveToDisk()
    }

    public func deleteProxy(list: [ProxyModel]) {

    }

    public func updateSubscribeURL(urls: [String]) {
        subscribeURLs = urls
    }

    // MARK: - Private Methods
}
