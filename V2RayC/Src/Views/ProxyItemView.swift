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
        v.drawsBackground = false
        v.textColor = NSColor(hex: 0x333333)
        v.font = NSFont.userFont(ofSize: 26)
        v.stringValue = "default"
        return v
    }()
    var addressLabel: NSTextField = {
        let v = NSTextField()
        v.wantsLayer = true
        v.isEditable = false
        v.isBezeled = false
        v.drawsBackground = false
        v.textColor = NSColor(hex: 0x999999)
        v.font = NSFont.userFont(ofSize: 14)
        v.stringValue = "default"
        return v
    }()
    var fromTypeLabelContainer: NSView = {
        let v = NSView()
        v.wantsLayer = true
        v.layer?.cornerRadius = 3
        v.layer?.backgroundColor = NSColor.white.cgColor
        return v
    }()
    var fromTypeLabel: NSTextField = {
        let v = NSTextField()
        v.wantsLayer = true
//        v.isEditable = false
//        v.isBezeled = false

        v.textColor = NSColor(hex: 0x291ACC)
        v.font = NSFont.userFont(ofSize: 12)
        v.layer?.backgroundColor = NSColor.white.cgColor
        v.stringValue = "default"
        v.alignment = NSTextAlignment.center
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
    
    func selected(flag: Bool) {
        nameLabel.textColor = flag ? NSColor.white : NSColor(hex: 0x333333)
        addressLabel.textColor = flag ? NSColor.white : NSColor(hex: 0x999999)
        
    }

    // MARK: - Views About
    override func layout() {
        super.layout()
        nameLabel.pin.top(15).left(18).width(220).height(34)
        addressLabel.pin.left(33).top(63).width(200).height(30)
        fromTypeLabelContainer.pin.right(27).top(96).width(83).height(30)
        fromTypeLabel.pin.vCenter().left().right().sizeToFit(.width)
    }

    // MARK: - Life Cycle
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        nameLabel.layer?.backgroundColor = NSColor.clear.cgColor
        addressLabel.layer?.backgroundColor = NSColor.clear.cgColor
        
        fromTypeLabelContainer.addSubview(fromTypeLabel)
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(fromTypeLabelContainer)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
