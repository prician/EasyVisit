//
//  Question.swift
//  Easyvisit
//
//  Created by WSH on 2022/5/1.
//

import Foundation
import UIKit

struct Question {
    var title: String
    var options: [Option]
    var answer: [Answer]
}

struct Option {
    var name: String
    var content: String = ""
}

struct Answer{
    var name: String
    var score: Double
}
