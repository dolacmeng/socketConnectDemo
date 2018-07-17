//
//  ViewController.swift
//  Client
//
//  Created by 许伟杰 on 2018/5/3.
//  Copyright © 2018年 JackXu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate lazy var socket : HYSocket = HYSocket(addr: "0.0.0.0", port: 7878)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if socket.connectServer() {
            print("连接上服务器")
        }
    }
}

