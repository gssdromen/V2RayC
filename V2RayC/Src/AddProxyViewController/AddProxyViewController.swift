//
//  AddProxyViewController.swift
//  V2RayC
//
//  Created by cedricwu on 2018/09/01.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa
import PinLayout
import SwiftHEXColors

protocol AddProxyViewDelegate: class {
    func addProxySuccess(proxy: ProxyModel)
}

class AddProxyViewController: NSViewController {
    @IBOutlet weak var psInput: NSTextField!
    @IBOutlet weak var addressInput: NSTextField!
    @IBOutlet weak var portInput: NSTextField!
    @IBOutlet weak var idInput: NSTextField!
    @IBOutlet weak var extraIDInput: NSTextField!
    @IBOutlet weak var securityInput: NSComboBox!
    @IBOutlet weak var networkInput: NSComboBox!
    @IBOutlet weak var tlsInput: NSComboBox!
    
    weak var delegate: AddProxyViewDelegate!
    
    // MARK: - Private Methods
    func verification() -> Bool {
        return false
    }
    
    // MARK: - UI Event
    @IBAction func confirmClicked(_ sender: NSButton) {
        view.window?.close()
    }
    
    @IBAction func importFromFile(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.begin { [weak self] (result) -> Void in
            if result == NSApplication.ModalResponse.OK {
                if let url = openPanel.url {
                    if let ss = self {
                        let proxyModel = ProxyModel()
                        proxyModel.from = ProxyFrom.custom
                        proxyModel.configPath = url.path
                        if let dele = ss.delegate {
                            dele.addProxySuccess(proxy: proxyModel)
                        }
                        ss.view.window?.close()
                    }
                }
            }
        }
    }
    
    @IBAction func cancelClicked(_ sender: NSButton) {
        view.window?.close()
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
