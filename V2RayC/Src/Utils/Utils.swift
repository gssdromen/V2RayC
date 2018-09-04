//
//  Utils.swift
//  V2RayC
//
//  Created by cedricwu on 2018/9/4.
//  Copyright © 2018年 cedric. All rights reserved.
//
import Foundation

func generateLaunchdPlist(path: String, configPath: String) -> Void {
    print(path)
    let v2rayPath = Bundle.main.path(forResource: "v2ray", ofType: nil)
    let plistDict: NSDictionary = [
        "Label": "com.dromen.V2RayC.v2ray-core",
        "ProgramArguments": [v2rayPath, "-config", configPath],
        "RunAtLoad": NSNumber(value: true)
    ]
    let flag = plistDict.write(toFile: path, atomically: false)
    print(flag)
}
