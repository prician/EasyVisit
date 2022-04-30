//
//  caseCache.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/30.
//

import Foundation
import UIKit
import SQLite

func saveCase(_ cases: [Case]) {
    guard let caseTable = createCaseTable() else { return }
    guard let db = connectDataBase() else { return }
    do {
        try cases.forEach { dia in
            let insert = caseTable.insert(Expression<String>("reason") <- dia.reason, Expression<String>("doctor") <- dia.doctor, Expression<String>("intro") <- dia.intro,Expression<String>("createdat") <- dia.createdAt)
            try db.run(insert)
        }
    } catch {
        print(error)
    }
}

func getCase() -> [Case]? {
    guard let db = connectDataBase() else { return nil }
    let caseTable = Table("case")
    do {
        let savedCase = try (try db.prepare(caseTable.select(*))).map { row -> Case in
            return Case(reason: try row.get(Expression<String>("reason")),
                         doctor: try row.get(Expression<String>("doctor")),
                         intro: try row.get(Expression<String>("intro")),
                        createdAt:try row.get(Expression<String>("createdAt")))
        }
        return savedCase
    } catch {
        print(error)
        return nil
    }
}

func deleteCase() {
    guard let db = connectDataBase() else { return }
    let caseTable = Table("case")
    let delete = caseTable.delete()
    do {
        try db.run(delete)
    } catch {
        print(error)
    }
}

func createCaseTable() -> Table? {
    guard let db = connectDataBase() else { return nil }
    let cases = Table("case")
    let createTableQuery = cases.create { builder in
        builder.column(Expression<Int>("id"), primaryKey: true)
        builder.column(Expression<String>("reason"))
        builder.column(Expression<String>("doctor"))
        builder.column(Expression<String>("intro"))
        builder.column(Expression<String>("createdAt"))
    }
    do {
        try db.run(createTableQuery)
        return cases
    } catch {
        return cases
    }
}
