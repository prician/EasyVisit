//
//  diaryCache.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/29.
//

import Foundation
import UIKit
import SQLite

func saveDiary(_ diary: [Diary]) {
    guard let diaryTable = createDiaryTable() else { return }
    guard let db = connectDataBase() else { return }
    do {
        try diary.forEach { dia in
            let insert = diaryTable.insert(Expression<String>("content") <- dia.content, Expression<String>("createdat") <- dia.createdAt)
            try db.run(insert)
        }
    } catch {
        print(error)
    }
}

func getDiary() -> [Diary]? {
    guard let db = connectDataBase() else { return nil }
    let diaryTable = Table("diary")
    do {
        let savedDiary = try (try db.prepare(diaryTable.select(*))).map { row -> Diary in
            return Diary(content: try row.get(Expression<String>("content")),
                         createdAt: try row.get(Expression<String>("createdat")))
        }
        return savedDiary
    } catch {
        print(error)
        return nil
    }
}

func deleteDiary() {
    guard let db = connectDataBase() else { return }
    let diaryTable = Table("diary")
    let delete = diaryTable.delete()
    do {
        try db.run(delete)
    } catch {
        print(error)
    }
}

func createDiaryTable() -> Table? {
    guard let db = connectDataBase() else { return nil }
    let diary = Table("diary")
    let createTableQuery = diary.create { builder in
        builder.column(Expression<Int>("id"), primaryKey: true)
        builder.column(Expression<String>("content"))
        builder.column(Expression<String>("createdat"))
    }
    do {
        try db.run(createTableQuery)
        return diary
    } catch {
        return diary
    }
}
