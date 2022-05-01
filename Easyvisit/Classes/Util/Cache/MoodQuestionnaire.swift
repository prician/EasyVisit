//
//  MoodQuestionnaire.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/5/1.
//

import Foundation
import UIKit
import SQLite

func saveMoodQ(_ moodQ: [MoodQ]) {
    guard let moodQTable = createMoodQTable() else { return }
    guard let db = connectDataBase() else { return }
    do {
        try moodQ.forEach { dia in
            let insert = moodQTable.insert(Expression<Double>("score") <- dia.score, Expression<String>("createdat") <- dia.createdAt)
            try db.run(insert)
        }
    } catch {
        print(error)
    }
}

func getMoodQ() -> [MoodQ]? {
    guard let db = connectDataBase() else { return nil }
    let moodQTable = Table("moodq")
    do {
        let savedMoodQ = try (try db.prepare(moodQTable.select(*))).map { row -> MoodQ in
            return MoodQ(score: try row.get(Expression<Double>("score")),
                         createdAt: try row.get(Expression<String>("createdat")))
        }
        return savedMoodQ
    } catch {
        print(error)
        return nil
    }
}

func deleteMoodQ() {
    guard let db = connectDataBase() else { return }
    let moodQTable = Table("moodq")
    let delete = moodQTable.delete()
    do {
        try db.run(delete)
    } catch {
        print(error)
    }
}

func createMoodQTable() -> Table? {
    guard let db = connectDataBase() else { return nil }
    let moodQ = Table("moodq")
    let createTableQuery = moodQ.create { builder in
        builder.column(Expression<Int>("id"), primaryKey: true)
        builder.column(Expression<Double>("score"))
        builder.column(Expression<String>("createdat"))
    }
    do {
        try db.run(createTableQuery)
        return moodQ
    } catch {
        return moodQ
    }
}
