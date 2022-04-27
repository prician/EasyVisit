//
//  ChatHistory.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/27.
//

import Foundation
import UIKit
import SQLite

func saveChatHistory(_ messages: [ChatMessage]) {
    guard let db = connectDataBase() else { return }
    let chathistory = Table("chathistory")
    let createTableQuery = chathistory.create { builder in
        builder.column(Expression<Int>("id"), primaryKey: true)
        builder.column(Expression<String>("content"))
        builder.column(Expression<Int>("user_id"))
        builder.column(Expression<String>("createdat"))
    }
    do {
        try db.run(createTableQuery)
        
    } catch {
        // chathistory表已存在
        let insert = chathistory.insert(Expression<String>("content") <- "hello", Expression<Int>("user_id") <- 2, Expression("createdat") <- "\(Date())")
//        db.run(insert)
    }
}

func getChatHistory() {
    
}
