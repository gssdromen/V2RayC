//
//  Utils.swift
//  V2RayC
//
//  Created by cedricwu on 2018/9/4.
//  Copyright © 2018年 cedric. All rights reserved.
//
import Foundation

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
    if model.from == ProxyFrom.custom {
        plistDict = [
            "Label": "com.dromen.V2RayC.v2ray-core",
            "ProgramArguments": [kV2rayBinaryPath, "-config", model.configPath ?? ""],
            "RunAtLoad": NSNumber(value: true)
        ]
    }
    return plistDict ?? NSDictionary()
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
