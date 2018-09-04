//
//  ProxyItemView.swift
//  V2RayC
//
//  Created by cedric on 2018/8/27.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa
import PinLayout
import SwiftHEXColors

class ProxyItemView: NSView {
    var nameLabel: NSTextField = {
        let v = NSTextField()
        v.wantsLayer = true
        v.isEditable = false
        v.isBezeled = false
        v.textColor = NSColor(hex: 0x333333)
        v.font = NSFont.userFont(ofSize: 30)
        v.stringValue = "default"
        return v
    }()
    var addressLabel: NSTextField = {
        let v = NSTextField()
        v.wantsLayer = true
        v.isEditable = false
        v.isBezeled = false
        v.textColor = NSColor(hex: 0x999999)
        v.font = NSFont.userFont(ofSize: 14)
        v.stringValue = "default"
        return v
    }()
    var fromTypeLabel: NSTextField = {
        let v = NSTextField()
        v.wantsLayer = true
        v.isEditable = false
        v.isBezeled = false
        v.textColor = NSColor(hex: 0x291ACC)
        v.font = NSFont.userFont(ofSize: 12)
        v.stringValue = "default"
        return v
    }()

    // MARK: - Public Methods
    func fillWith(model: ProxyModel) {
        nameLabel.stringValue = model.remarks ?? ""
        addressLabel.stringValue = model.address ?? ""
        if let type = model.from {
            switch type {
            case .custom:
                fromTypeLabel.stringValue = "来自配置文件"
                break
            case .normal:
                fromTypeLabel.stringValue = ""
                break
            case .subscribtion:
                fromTypeLabel.stringValue = "来自订阅"
                break
            }
        }
    }

    // MARK: - Views About
    override func layout() {
        super.layout()
        nameLabel.pin.top(27).left(29).width(200).height(32)
        addressLabel.pin.left(33).top(72).width(150).height(30)
        fromTypeLabel.pin.right(27).top(96).width(100).height(30)
    }

    // MARK: - Life Cycle
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(fromTypeLabel)
        nameLabel.layer?.backgroundColor = NSColor.red.cgColor
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
