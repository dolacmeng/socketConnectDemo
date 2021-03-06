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
        
        let userInfo = UserInfo.Builder()
        userInfo.name = "Jack"
        userInfo.level = 10
        
        let textMessage = TextMessage.Builder()
        textMessage.user = try! userInfo.build()
        textMessage.text = message
        let msgData = (try! textMessage.build()).data()
        
        //1.获取消息长度
        var length = msgData.count
        
        //将消息长度写入data
        let headerData = Data(bytes:&length, count: 4)
        
        //发送消息
        let totalData = headerData + msgData
        self.sendMsg(data: totalData)
    }
    
    func startReadMsg() {
        DispatchQueue.global().async {
            while true {
                 guard let lMsg = self.tcpClient.read(4) else{
                    continue
                 }
                //获取数据长度的data
                let lMsgData = Data(bytes: lMsg, count: 4)
                var length : Int = 0
                (lMsgData as NSData).getBytes(&length, length: 4)
                
                //根据长度读取消息
                guard let msg = self.tcpClient.read(length) else{
                    return
                }
                let msgData  = Data(bytes: msg, count: length)
                
                let message = try! TextMessage.parseFrom(data: msgData)
                let user = message.user
                print("来自" + (user?.name)! + "的消息:" + message.text)
            }
        }
    }
    
}
