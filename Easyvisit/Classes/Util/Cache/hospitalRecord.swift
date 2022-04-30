//
//  hospitalRecord.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/30.
//

import Foundation
import UIKit
import SQLite

func saveHospitalRecord(_ department: [Department]) {
    guard let departmentTable = createDepartmentTable() else { return }
    guard let db = connectDataBase() else { return }
    do {
        try department.forEach { dia in
            let insert = departmentTable.insert(Expression<String>("name") <- dia.name, Expression<String>("createdat") <- dia.createdAt, Expression<String>("depar") <- dia.depar, Expression<String>("time") <- dia.time)
            try db.run(insert)
        }
    } catch {
        print(error)
    }
}

func getDepartment() -> [Department]? {
    guard let db = connectDataBase() else { return nil }
    let departmentTable = Table("department")
    do {
        let savedDepartment = try (try db.prepare(departmentTable.select(*))).map { row -> Department in
            return Department(name: try row.get(Expression<String>("name")),
                              depar: try row.get(Expression<String>("depar")),
                              time: try row.get(Expression<String>("time")),
                              createdAt: getTimeStamp(Date()))
        }
        return savedDepartment
    } catch {
        print(error)
        return nil
    }
}

func deleteDepartment() {
    guard let db = connectDataBase() else { return }
    let departmentTable = Table("department")
    let delete = departmentTable.delete()
    do {
        try db.run(delete)
    } catch {
        print(error)
    }
}

func createDepartmentTable() -> Table? {
    guard let db = connectDataBase() else { return nil }
    let department = Table("department")
    let createTableQuery = department.create { builder in
        builder.column(Expression<Int>("id"), primaryKey: true)
        builder.column(Expression<String>("name"))
        builder.column(Expression<String>("depar"))
        builder.column(Expression<String>("createdat"))
        builder.column(Expression<String>("time"))
    }
    do {
        try db.run(createTableQuery)
        return department
    } catch {
        return department
    }
}
