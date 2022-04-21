//
//  Int + Fit.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/21.
//

import Foundation
import UIKit

extension Int {
    
    //基于iPhone 13 Pro Max
    
    var fw: Int {
        return Int(Float(self) * Float(UIScreen.main.bounds.size.width / 428.0))
    }
    
    var fh: Int {
        return Int(Float(self) * Float(UIScreen.main.bounds.size.height / 926.0))
    }

}
