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
    
    @IBOutlet weak var contentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    //点击发送
    @IBAction func clickSend(_ sender: UIButton) {
        guard let content = contentTextField.text else{
            return
        }
        
        socket.sendMsg(message: content);
    }
    
    //点击连接
    @IBAction func clickConnect(_ sender: UIButton) {
        if socket.connectServer() {
            print("连接上服务器")
            socket.sendMsg(message: "您好啊，服务器");
        }
    }
    
    
    @IBAction func clickDisconnect(_ sender: UIButton) {
    }
    
    
}


