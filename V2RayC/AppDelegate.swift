//
//  AppDelegate.swift
//  V2RayC
//
//  Created by cedric on 2018/8/25.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var updateSubscribeButton: NSMenuItem!
    
    // MARK: - Main Menu Event
    @IBAction func updateSubscribe(_ sender: NSMenuItem) {
        if let mw = NSApp.mainWindow, let vc = mw.contentViewController as? MainProxyListViewController {
            vc.refreshSubscribe()
        }
    }
    
    @IBAction func menuPreferencesClicked(_ sender: NSMenuItem) {
        if let window = NSApp.mainWindow {
            
        }
    }

    // MARK: - Life Cycle
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        // 创建Launch要用到的文件夹
        if !FileManager.default.fileExists(atPath: kV2rayConfigFolderPath) {
            let path = Bundle.main.path(forResource: "initLaunchPath", ofType: "sh")
            _ = runShell(shellFilePath: path!)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
