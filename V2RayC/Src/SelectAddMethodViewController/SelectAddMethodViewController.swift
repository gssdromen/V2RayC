//
//  SelectAddMethodViewController.swift
//  V2RayC
//
//  Created by cedric on 2018/9/13.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa

protocol SelectAddMethodViewControllerDelegate: class {
    func normalButtonClicked()
    func fromConfigFileButtonClicked()
    func fromSubscribeButtonClicked()
}

class SelectAddMethodViewController: NSViewController {
    
    weak var delegate: SelectAddMethodViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func normalButtonClicked(_ sender: Any) {
        dismiss(self)
        if let d = delegate {
            d.normalButtonClicked()
        }
    }
    
    @IBAction func fromConfigFileClicked(_ sender: Any) {
        dismiss(self)
        if let d = delegate {
            d.fromConfigFileButtonClicked()
        }
    }
    
    @IBAction func fromSubscribeClicked(_ sender: Any) {
        dismiss(self)
        if let d = delegate {
            d.fromSubscribeButtonClicked()
        }
    }
}
