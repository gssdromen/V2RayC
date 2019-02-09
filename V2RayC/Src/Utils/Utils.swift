//
//  Utils.swift
//  V2RayC
//
//  Created by cedricwu on 2018/9/4.
//  Copyright © 2018年 cedric. All rights reserved.
//
import Foundation
import Cocoa
import RxSwift
import RxAtomic
import RxCocoa
import Alamofire

func generateLaunchdPlistFromProxyModel(model: ProxyModel) -> Void {
    let isDir: UnsafeMutablePointer<ObjCBool> = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
    let isFileExist = FileManager.default.fileExists(atPath: kV2rayCPlistFolderPath, isDirectory: isDir)

    if !isFileExist {
        do {
            try FileManager.default.createDirectory(atPath: kV2rayCPlistFolderPath, withIntermediateDirectories: true, attributes: nil)
        } catch let err {
            fatalError(err.localizedDescription)
        }
    }

    genPlistFromProxyModel(model: model).write(toFile: kV2rayCPlistPath, atomically: false)
}

func genPlistFromProxyModel(model: ProxyModel) -> NSDictionary {
    var plistDict: NSDictionary?

    plistDict = [
        "Label": "com.dromen.V2RayC.v2ray-core",
        "ProgramArguments": [kV2rayBinaryPath, "-config", model.configPath ?? ""],
        "RunAtLoad": NSNumber(value: true)
    ]

    return plistDict ?? NSDictionary()
}

func convertStringToDictionary(text: String) -> [String: AnyObject]? {
    if let data = text.data(using: String.Encoding.utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions(rawValue: 0)]) as? [String: AnyObject]
        } catch let error as NSError {
            print(error)
        }
    }
    return nil
}

func runCommandLine(binPath: String, args: [String]?) -> Int32 {
    let task = Process()
    task.launchPath = binPath
    task.arguments = args

    let stdoutPipe = Pipe()
    let stderrPipe = Pipe()
    task.standardOutput = stdoutPipe
    task.standardError = stderrPipe
    let stdoutReader = stdoutPipe.fileHandleForReading
    let stderrReader = stderrPipe.fileHandleForReading

    task.launch()

    print(String(data: stdoutReader.readDataToEndOfFile(), encoding: String.Encoding.utf8) ?? "NO stdout")
    print(String(data: stderrReader.readDataToEndOfFile(), encoding: String.Encoding.utf8) ?? "NO stderr")
    task.waitUntilExit()
    return task.terminationStatus
}

func runShell(shellFilePath: String) -> Bool {
    let scriptString = "do shell script \"bash \(shellFilePath)\" with administrator privileges"
    if let appleScript = NSAppleScript(source: scriptString) {
        var possibleError: NSDictionary?
        if let outputString = appleScript.executeAndReturnError(&possibleError).stringValue {
            print(outputString)
            return true
        } else if (possibleError != nil) {
            print("error: ", possibleError!)
            return false
        }
    }

    return false
}

func genDefaultProxyConfigModel() -> ProxyConfigModel {
    let jsonString = """
{"log":{"loglevel":"warning"},"dns":{"servers":["119.29.29.29","8.8.8.8","208.67.222.222","8.8.4.4","208.67.220.220","localhost"]},"outbound":{"tag":"proxy","protocol":"vmess","mux":{"enable":true,"concurrency":8},"streamSettings":{"network":"tcp","tcpSettings":{"header":{"type":"none"},"connectionReuse":true},"kcpSettings":{"header":{"type":"none"},"mtu":1350,"congestion":false,"tti":50,"uplinkCapacity":5,"writeBufferSize":1,"readBufferSize":2,"downlinkCapacity":20},"security":"tls","tlsSettings":{"allowInsecure":false},"wsSettings":{"path":"","headers":{"Host":""},"connectionReuse":true}},"settings":{"vnext":[{"address":"","port":0,"users":[{"id":"","alterId":0,"security":"chacha20-poly1305"}]}]}},"outboundDetour":[{"protocol":"freedom","tag":"direct","settings":{}}],"inbound":{"listen":"0.0.0.0","port":1081,"protocol":"socks","settings":{"ip":"127.0.0.1","auth":"noauth","udp":true},"allowPassive":false},"inboundDetour":[{"listen":"0.0.0.0","allocate":{"strategy":"always","refresh":5,"concurrency":3},"port":8001,"protocol":"http","tag":"httpDetour","domainOverride":["http","tls"],"streamSettings":{},"settings":{"timeout":0}}],"routing":{"strategy":"rules","settings":{"domainStrategy":"IPIfNonMatch","rules":[{"type":"field","port":"1-52","outboundTag":"direct"},{"type":"field","port":"54-79","outboundTag":"direct"},{"type":"field","port":"81-442","outboundTag":"direct"},{"type":"field","port":"444-3999","outboundTag":"direct"},{"type":"field","port":"4001-65535","outboundTag":"direct"},{"type":"field","domain":["geosite:cn","geoip:cn"],"outboundTag":"direct"},{"type":"chinaip","outboundTag":"direct"},{"type":"chinasites","outboundTag":"direct"},{"type":"field","ip":["0.0.0.0/8","10.0.0.0/8","100.64.0.0/10","127.0.0.0/8","169.254.0.0/16","172.16.0.0/12","192.0.0.0/24","192.0.2.0/24","192.168.0.0/16","198.18.0.0/15","198.51.100.0/24","203.0.113.0/24","::1/128","fc00::/7","fe80::/10","geoip:cn"],"outboundTag":"direct"},{"type":"field","domain":[".goo","ggpht","gstatic","github","facebook.com","fbcdn.net","youtube.com","youtu.be","ytimg.com","twitter.com","twimg.com","twitpic.com","t.co","bitly.com","j.mp","bit.ly","blogspot","blogger","blogblog","dropbox.com","flickr.com","udn.com","chinagfw.org","godoc.org","golang.org","gravatar.com","gstatic.com","mediafire.com","wikipedia.com","wikipedia.org","icloud.com","config.getsync.com","config.resilio.com"],"outboundTag":"proxy"},{"type":"field","ip":["173.244.217.42/32","209.95.56.60/32","107.182.230.198/32","173.244.209.150/32","54.235.182.157/32"],"outboundTag":"proxy"}]}}}
"""
    let model = ProxyConfigModel(JSONString: jsonString)
    return model!
}

public func getUUID() -> String {
    let uuidRef = CFUUIDCreate(nil)
    let uuidStringRef = CFUUIDCreateString(nil, uuidRef)
    let uuidString = uuidStringRef as String?
    return uuidString ?? ""
}

func fetchSubscribeContentFrom(url: String) -> Driver<String> {
    let obj = Observable<String>.create { (observer) -> Disposable in
        Alamofire.request(url).responseJSON { response in
            if let resp = response.response, resp.statusCode == 200 {
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    observer.onNext(utf8Text)
                    observer.onCompleted()
                }
            }
        }
        return Disposables.create()
    }
    return obj.asDriver(onErrorJustReturn: "")
}
