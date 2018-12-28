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
    func addSubscribeUrlSuccess(subscribeUrl: String)
}

class AddProxyViewController: NSViewController {
    var subscribeView = AddSubscribeView()
    @IBOutlet weak var psInput: NSTextField!
    @IBOutlet weak var addressInput: NSTextField!
    @IBOutlet weak var portInput: NSTextField!
    @IBOutlet weak var idInput: NSTextField!
    @IBOutlet weak var extraIDInput: NSTextField!
    @IBOutlet weak var networkInput: NSComboBox!
    @IBOutlet weak var tlsInput: NSComboBox!
    
    weak var delegate: AddProxyViewDelegate!
    
    // MARK: - Private Methods
    func confirmHandler() {
        let ps = psInput.stringValue
        let address = addressInput.stringValue
        let port = portInput.stringValue
        let id = idInput.stringValue
        let alterID = extraIDInput.stringValue
        let network = networkInput.stringValue
        let tls = tlsInput.stringValue
        
        let isVerification = verification(ps: ps, address: address, port: port, id: id, alterID: alterID, network: network, tls: tls)
        if !isVerification {
            // 校验失败
            let alertVC = NSAlert()
            alertVC.messageText = "数据校验出错"
            alertVC.alertStyle = .informational
            alertVC.runModal()
        }
        let proxyModel = ProxyModel()
        proxyModel.remarks = ps
        proxyModel.address = address
        proxyModel.port = Int(port)
        proxyModel.id = id
        proxyModel.alterID = Int(alterID)
        proxyModel.security = .auto
        proxyModel.network = .tcp
        proxyModel.tls = tls == "Yes"
    }
    
    func verification(ps: String, address: String, port: String, id: String, alterID: String, network: String, tls: String) -> Bool {
        if ps.count == 0 {
            return false
        }
        if address.count == 0 {
            return false
        }
        if port.count == 0 || UInt(port) == nil || port == "0" {
            return false
        }
        if id.count == 0 {
            return false
        }
        if alterID.count == 0 || UInt(alterID) == nil || alterID == "0" {
            return false
        }
        if network.count == 0 {
            return false
        }
        if tls.count == 0 {
            return false
        } else if !["Yes", "No"].contains(tls) {
            return false
        }
        return true
    }
    
    // MARK: - UI Event
    @IBAction func confirmClicked(_ sender: NSButton) {
        confirmHandler()
//        view.window?.close()
    }
    
    @IBAction func cancelClicked(_ sender: NSButton) {
        view.window?.close()
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeView.delegate = self
    }
    
}

extension AddProxyViewController: AddSubscribeViewDelegate {
    func subscribeViewConfirmClicked(view: AddSubscribeView, url: String) {
        if let dele = delegate {
            dele.addSubscribeUrlSuccess(subscribeUrl: url)
        }
    }
}
