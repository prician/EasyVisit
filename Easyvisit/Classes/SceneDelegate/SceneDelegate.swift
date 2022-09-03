//
//  SceneDelegate.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/21.
//

import UIKit
import SocketIO
import SwiftyJSON
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        window?.rootViewController = tabBar()
        config()
        print(NSHomeDirectory())
        createUser()
    }

    //配置socket
    func configSocket(success: () -> Void) {
        socketManager = SocketManager(socketURL: URL(string: socketURLString)!, config: [.compress, .log(true)])
        socket = socketManager.socket(forNamespace: "/privatechat")
        socket.on(clientEvent: .connect) { _, _ in
            LTXLogger.shared.log("socket连接成功")
        }
        socket.on("receive") { data, _ in
            LTXLogger.shared.log("接收到一条消息")
            guard let dataFirst = data.first else {
                LTXLogger.shared.log("接收到的消息为空")
                return
            }
            guard let dataString = dataFirst as? String else {
                LTXLogger.shared.log("接收到的消息为非字符串")
                return
            }
            let json = JSON(parseJSON: dataString)
            guard let room = json["room"].string else { return }
        }
        success()
    }
    
    func config() {
        configSocket {
            socket.connect()
        }
        guard UserDefaults.standard.value(forKey: "uid") != nil else {
            createUser()
            return
        }
    }
    
    func createUser() {
        let uid = arc4random()
        UserDefaults.standard.setValue(uid, forKey: "uid")
        AF.request(apiProtocol + "://" + apiHost + ":" + apiPort, method: .post).responseString { response in
            switch response.result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        LTXLogger.shared.log("新用户创建成功, uid为\(uid)")
    }

}

