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
//    public private(set) var proxyModels = Variable<[ProxyModel]>([])
    public private(set) var proxyModelSignal = BehaviorSubject<Int>(value: 0)
    public private(set) var proxyModels = [ProxyModel]()
    public private(set) var subscribeURLs = [String]()
    public private(set) var currentRunningProxyModel: ProxyModel?

    // MARK: - Private Methods
    /// 用ProxyModel里的数据生成启动要用的plist
    private func prepareStartParams(model: ProxyModel) {
        if let from = model.from {
            switch from {
            case ProxyFrom.subscribtion:
                let configModel = genDefaultProxyConfigModel()
                configModel.fillWith(model: model)
                model.configPath = configModel.writeToConfigJsonFile()
            case ProxyFrom.custom:
                break
            case ProxyFrom.normal:
                let configModel = genDefaultProxyConfigModel()
                configModel.fillWith(model: model)
                model.configPath = configModel.writeToConfigJsonFile()
            }
        }
        generateLaunchdPlistFromProxyModel(model: model)
    }

    /// 用Launchctl运行V2Ray服务
    private func startWithLaunchctl() {
        DispatchQueue.global().async {
            _ = runCommandLine(binPath: "/bin/launchctl", args: ["unload", "-w", kV2rayCPlistPath])
            _ = runCommandLine(binPath: "/bin/launchctl", args: ["load", "-w", kV2rayCPlistPath])
        }
    }

    /// 用Launchctl停止运行V2Ray服务
    private func stopWithLaunchctl() {
        DispatchQueue.global().async {
            _ = runCommandLine(binPath: "/bin/launchctl", args: ["unload", "-w", kV2rayCPlistPath])
        }
    }
}

// MARK: - Public Methods 保存 读取 相关
extension ProxyListManager {
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
        subscribeURLs = UserDefaults.standard.stringArray(forKey: kSubscribeURLUserDefaultsKey) ?? []
    }
}

// MARK: - Public Methods 启动 停止 相关
extension ProxyListManager {
    public func getCurrentProxyModel() -> ProxyModel? {
        return currentRunningProxyModel
    }

    public func startProxy(index: Int) {
        if index < proxyModels.count {
            for i in 0 ..< proxyModels.count {
                let model = proxyModels[i]
                if index == i {
                    model.isSelected = true
                    currentRunningProxyModel = model
                    prepareStartParams(model: model)
                    startWithLaunchctl()
                } else {
                    model.isSelected = false
                }
            }
        }
    }

    public func stopAllProxy() {
        for model in proxyModels {
            model.isSelected = false
        }
        stopWithLaunchctl()
    }
}

// MARK: - Public Methods 添加 删除 相关
extension ProxyListManager {
    /// 清除所有类型是订阅的ProxyModel，准备更新
    public func clearAllSubscibe() {
        proxyModels = proxyModels.filter { (proxyModel) -> Bool in
            return proxyModel.from != ProxyFrom.subscribtion
        }
        proxyModelSignal.onNext(0)
    }

    /// 新增代理
    ///
    /// - Parameters:
    ///   - list: 代理列表
    ///   - at: 添加在哪个index，不传默认添加在最后，超出范围也添加在最后
    public func addProxy(list: [ProxyModel], at: Int?) {
        if at == nil || at! >= proxyModels.count {
            proxyModels.append(contentsOf: list)
        } else {
            for model in list {
                proxyModels.insert(model, at: at!)
            }
        }
        saveToDisk()
    }

    /// 删除代理
    ///
    /// - Parameter list: 代理列表
    public func deleteProxy(list: [ProxyModel]) {

    }

    /// 更新所有订阅的地址
    ///
    /// - Parameter urls: 订阅地址
    public func updateSubscribeURL(urls: [String]) {
        subscribeURLs = urls
    }

    /// 从订阅的链接中更新订阅
    public func updateProxyFromSubscribe() {
        for url in subscribeURLs {
            
        }
    }
}
