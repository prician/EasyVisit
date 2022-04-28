//
//  time.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/28.
//

import Foundation
import UIKit

func getTimeStamp(_ date: Date) -> String {
    let timeInterval = date.timeIntervalSince1970
    return String(timeInterval) 
}
