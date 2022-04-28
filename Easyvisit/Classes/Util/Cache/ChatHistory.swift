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
        try messages.forEach { chatMessage in
            let insert = chathistory.insert(Expression<String>("content") <- chatMessage.text!, Expression<Int>("user_id") <- chatMessage.uid!, Expression<String>("createdat") <- getTimeStamp(Date()))
            try db.run(insert)
        }
    } catch {
        print(error)
    }
}

func getChatHistory() -> [ChatMessage]? {
    guard let db = connectDataBase() else { return nil }
    let chathistory = Table("chathistory")
    do {
        let savedHistory = try (try db.prepare(chathistory.select(*))).map { row -> ChatMessage in
            return ChatMessage(text: try row.get(Expression<String>("content")),
                               uid: try row.get(Expression<Int>("user_id")),
                               time: 100)
        }
        return savedHistory
    } catch {
        print(error)
        return nil
    }
}

func deleteChatHistory() {
    guard let db = connectDataBase() else { return }
    let chathistory = Table("chathistory")
    let delete = chathistory.delete()
    do {
        try db.run(delete)
    } catch {
        print(error)
    }
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
