//
//  AddSubscribeViewController.swift
//  V2RayC
//
//  Created by cedricwu on 2018/09/14.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa

protocol AddSubscribeViewControllerDelegate: NSObjectProtocol {
    func confirmButtonClicked(str: String)
}

class AddSubscribeViewController: NSViewController {
    @IBOutlet weak var scrollView: NSScrollView!

    var initialTextString = ""

    weak var delegate: AddSubscribeViewControllerDelegate?

    // MARK: - UI Event
    @IBAction func confirmButtonClicked(_ sender: Any) {
        dismissViewController(self)
        if let d = delegate, let textView = scrollView.documentView as? NSTextView {
            let str = textView.string
            d.confirmButtonClicked(str: str)
        }
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let textView = scrollView.documentView as? NSTextView {
            textView.string = initialTextString
        }
    }
}
