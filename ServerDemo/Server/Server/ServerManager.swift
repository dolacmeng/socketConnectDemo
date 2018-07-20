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
    fileprivate lazy var clientMrgs : [ClientManager] = [ClientManager]()
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
                    DispatchQueue.global().async {
                        print("接受到一个客户端的连接")
                        self.handlerClient(client)
                    }
                }
            }
        }
    }
    
    func stopRunning() {
        isServerRunning = false
    }
}

extension ServerManager{
    fileprivate func handlerClient(_ client : TCPClient){
        //用一个ClientManager管理TCPClient
        let mgr = ClientManager(tcpClient:client)
        mgr.delegate = self;
        
        //保存客户端
        clientMrgs.append(mgr)
        
        //用client开始接收消息
        mgr.startReadMsg()
    }
}


extension ServerManager : ClientManagerDelegate{
    func sendMsgClient(_ data: Data) {
        for mgr in clientMrgs{
            mgr.tcpClient.send(data: data)
        }
    }
}

