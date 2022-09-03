//
//  LTXLogger.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/5/3.
//

import Foundation
import UIKit

class LTXLogger {
    
    static let shared = LTXLogger()
    
    
    //在这里可以设置输出的各种格式
    func log(_ string: String) {
        print("==>" + string)
    }
    
}
