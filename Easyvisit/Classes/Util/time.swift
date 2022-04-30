//
//  time.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/28.
//

import Foundation
import UIKit

struct LTDate {
    var year: Int
    var month: Int
    var day: Int
    var hour: Int = 0
    var mintue: Int = 0
    var second: Int = 0
}

func getTimeStamp(_ date: Date) -> String {
    let timeInterval = date.timeIntervalSince1970
    return String(timeInterval) 
}

func parseTimeStamp(_ timestamp: String) -> Date {
    let date = Date(timeIntervalSince1970: TimeInterval(Float(timestamp)!))
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMddHHmmss"
    let formatString = formatter.string(from: date)
    return date
}
