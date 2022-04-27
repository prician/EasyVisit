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
    guard let chathistory = createChatHistoryTable() else { return }
    guard let db = connectDataBase() else { return }
    do {
        let savedHistory = (try db.prepare(chathistory.select(*))).map { row -> ChatMessage in
//            return ChatMessage(text: row.get(Expression<String>("content")),
//                               uid: <#T##Int?#>,
//                               time: <#T##Int?#>)
        }
    } catch {
        
    }
}

func getChatHistory() {
    
}

func createChatHistoryTable() -> Table? {
    guard let db = connectDataBase() else { return nil }
    let chathistory = Table("chathistory")
    let createTableQuery = chathistory.create { builder in
        builder.column(Expression<Int>("id"), primaryKey: true)
        builder.column(Expression<String>("content"))
        builder.column(Expression<Int>("user_id"))
        builder.column(Expression<String>("createdat"))
    }
    do {
        try db.run(createTableQuery)
        return chathistory
    } catch {
        return chathistory
    }
}
