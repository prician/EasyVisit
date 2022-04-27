//
//  sqlite.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/27.
//

import Foundation
import SQLite

func connectDataBase() -> Connection?  {
    do {
        let db = try Connection(NSHomeDirectory() + "/Documents/easyvisit.sqlite3")
        return db
    } catch {
        print("连接数据库失败")
        return nil
    }
}
