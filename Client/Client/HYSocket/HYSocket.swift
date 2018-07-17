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
        let temp = tcpClient.connect(timeout: 5)
        print(temp.1)
        return temp.0
    }
}
