//
//  ProxyItemAddView.swift
//  V2RayC
//
//  Created by cedric on 2018/8/27.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa
//import LayoutKit
import PinLayout

class ProxyItemAddView: NSView {
//    var addMarkLayout: SizeLayout<NSImageView>?
    var addMark = NSImageView()

    // MARK: - Views About
    override func layout() {
        super.layout()
        addMark.pin.width(57).height(57).center()
    }

    // MARK: - Life Cycle
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        
        addMark.image = NSImage(named: NSImage.Name(rawValue: "icon_ProxyItemAddView_Add"))
        addSubview(addMark)
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
