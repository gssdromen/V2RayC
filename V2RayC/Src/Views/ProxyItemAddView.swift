//
//  ProxyItemAddView.swift
//  V2RayC
//
//  Created by cedric on 2018/8/27.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa
import LayoutKit

class ProxyItemAddView: NSView {

    // MARK: - Views About


    // MARK: - Life Cycle
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        let addMark = SizeLayout<NSImageView>(
            width: 57,
            height: 57,
            alignment: .center,
            config: { imageView in
                let addImage = NSImage(named: NSImage.Name(rawValue: "icon_ProxyItemAddView_Add"))
                imageView.image = addImage
            }
        )
        addMark.arrangement().makeViews(in: self, direction: UserInterfaceLayoutDirection.leftToRight)
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
