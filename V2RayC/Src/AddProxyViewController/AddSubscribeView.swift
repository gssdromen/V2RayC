//
//  AddSubscribeView.swift
//  V2RayC
//
//  Created by cedricwu on 2018/09/06.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa
import PinLayout

protocol AddSubscribeViewDelegate: class {
    func subscribeViewConfirmClicked(view: AddSubscribeView, url: String)
}

class AddSubscribeView: NSView {
    let subscribeUrlInput = NSTextField()
    let confirmButton = NSButton()

    weak var delegate: AddSubscribeViewDelegate!
    
    // MARK: - UI Event
    @objc func confirmButtonClicked() {
        print("subscribeUrlInput: \(subscribeUrlInput.stringValue)")
        if let dele = delegate {
            dele.subscribeViewConfirmClicked(view: self, url: subscribeUrlInput.stringValue)
        }
    }
    
    // MARK: - Views About
    override func layout() {
        super.layout()
        subscribeUrlInput.pin.vCenter().width(200).height(33)
        confirmButton.pin.after(of: subscribeUrlInput).marginLeft(50).width(50).height(30).vCenter()
    }
    
    func setupSubscribeUrlInput() {
        subscribeUrlInput.font = NSFont.userFont(ofSize: 18)
    }
    
    func setupConfirmButton() {
        confirmButton.title = "确定"
        confirmButton.action = #selector(AddSubscribeView.confirmButtonClicked)
    }
    
    // MARK: - Life Cycle
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        setupSubscribeUrlInput()
        setupConfirmButton()
        addSubview(subscribeUrlInput)
        addSubview(confirmButton)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
