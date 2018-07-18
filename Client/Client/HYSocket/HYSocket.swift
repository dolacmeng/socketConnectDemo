//
//  HYSocket.swift
//  Client
//
//  Created by 许伟杰 on 2018/5/3.
//  Copyright © 2018年 JackXu. All rights reserved.
//

import UIKit

class HYSocket {
    fileprivate var tcpClient : TCPClient
    
    init(addr : String, port : Int) {
        tcpClient = TCPClient(addr:addr, port:port)
    }
}

extension HYSocket {
    func connectServer() -> Bool {
        return tcpClient.connect(timeout: 5).0
    }
    
    func sendMsg(data : Data){
        tcpClient.send(data: data)
    }
    
    func sendMsg(message: String) {
        //1.获取消息长度
        let data = message.data(using: .utf8)!
        print(data.count)
        var length = data.count
        
        //将消息长度写入data
        let headerData = Data(bytes:&length, count: 4)
        
        //发送消息
        let totalData = headerData + data
        self.sendMsg(data: totalData)
    }
}
