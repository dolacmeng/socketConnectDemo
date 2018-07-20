//
//  ClientManager.swift
//  Server
//
//  Created by 许伟杰 on 2018/7/17.
//  Copyright © 2018年 xmg. All rights reserved.
//

import Cocoa

protocol ClientManagerDelegate : class{
    func sendMsgClient(_ data : Data)
}

class ClientManager: NSObject {
    var tcpClient : TCPClient
    
    weak var delegate : ClientManagerDelegate?
    
    fileprivate var isClientConnect : Bool = false
    
    init(tcpClient : TCPClient){
        self.tcpClient = tcpClient
    }
}

extension ClientManager{
    func startReadMsg(){
        isClientConnect = true
        while isClientConnect {
            if let lMsg = tcpClient.read(4){
                //获取数据长度的data
                let lMsgData = Data(bytes: lMsg, count: 4)
                var length : Int = 0
                (lMsgData as NSData).getBytes(&length, length: 4)
                
                //根据长度读取消息
                guard let msg = tcpClient.read(length) else{
                    return
                }
                let msgData  = Data(bytes: msg, count: length)
                
                let message = try! TextMessage.parseFrom(data: msgData)
                let user = message.user
                print("接收到来自" + (user?.name)! + "的消息:" + message.text)
                
                //代理转发
                delegate?.sendMsgClient(lMsgData+msgData)
            }else{
                isClientConnect = false
                print("客户端断开了连接")
            }
        }
    }
}
