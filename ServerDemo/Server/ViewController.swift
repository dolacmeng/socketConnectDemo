//
//  ViewController.swift
//  Server
//
//  Created by 小码哥 on 2016/12/11.
//  Copyright © 2016年 xmg. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var hintLabel: NSTextField!
    fileprivate lazy var serverMgr : ServerManager = ServerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startServer(_ sender: NSButton) {
        serverMgr.startRunning()
        hintLabel.stringValue = "服务器已经开启ing"
    }
    
    @IBAction func stopServer(_ sender: NSButton) {
        serverMgr.stopRunning()
        hintLabel.stringValue = "服务器未开启"
    }
}

