//
//  Constant.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/21.
//

import Foundation
import UIKit
import SocketIO

let screenWidth = UIScreen.main.bounds.size.width //屏幕宽度
let screenHeight = UIScreen.main.bounds.size.height //屏幕高度

let themeColor = UIColor(red: 88/255.0, green: 95/255.0, blue: 221/255.0, alpha: 1)

let socketURLString = "http://127.0.0.1:7001"

var socketManager: SocketManager!

var socket: SocketIOClient!

let apiProtocol = "http"

let apiHost = "localhost"

let apiPort = "7001"


