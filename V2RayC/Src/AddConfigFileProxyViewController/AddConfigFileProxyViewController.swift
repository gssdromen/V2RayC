//
//  AddConfigFileProxyViewController.swift
//  V2RayC
//
//  Created by cedricwu on 2018/12/28.
//  Copyright © 2018 cedric. All rights reserved.
//

import Cocoa
import PinLayout

protocol AddConfigFileProxyViewControllerDelegate: NSObjectProtocol {
    func addConfigFileProxyComplete(proxyModel: ProxyModel)
}

class AddConfigFileProxyViewController: NSViewController {
    weak var delegate: AddConfigFileProxyViewControllerDelegate?
    
    @IBOutlet weak var psInput: NSTextField!
    
    @IBOutlet weak var selectButton: NSButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func cancelClicked(_ sender: NSButton) {
        if let window = view.window {
            window.close()
        }
    }
    
    @IBAction func selectConfigFileButtonClicked(_ sender: NSButton) {
        let psName = psInput.stringValue
        guard psName != "" else {
            let err = NSError(domain: "别名不可为空", code: -100, userInfo: nil)
            let alert = NSAlert(error: err)
            alert.runModal()
            return
        }
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
                        proxyModel.remarks = psName
                        if let d = ss.delegate {
                            d.addConfigFileProxyComplete(proxyModel: proxyModel)
                        }
                        ss.view.window?.close()
                    }
                }
            }
        }
    }
}
