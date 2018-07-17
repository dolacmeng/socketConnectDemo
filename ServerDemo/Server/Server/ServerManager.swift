//
//  ServerManager.swift
//  Server
//
//  Created by 小码哥 on 2016/12/11.
//  Copyright © 2016年 xmg. All rights reserved.
//  192.168.33.252

import Cocoa

class ServerManager: NSObject {
    fileprivate lazy var serverSocket : TCPServer = TCPServer(addr: "0.0.0.0", port: 7878)
    
    fileprivate var isServerRunning : Bool = false
}

extension ServerManager {
    func startRunning() {
        // 1.开启监听
        serverSocket.listen()
        isServerRunning = true
        
        // 2.开始接受客户端
        DispatchQueue.global().async {
            while self.isServerRunning {
                if let client = self.serverSocket.accept() {
                    print("接受到一个客户端的连接")
                }
            }
        }
    }
    
    func stopRunning() {
        isServerRunning = false
    }
    
}

