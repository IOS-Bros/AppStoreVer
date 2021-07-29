//
//  SQLite.swift
//  pet_prototype
//
//  Created by SeungYeon on 2021/07/29.
//

import Foundation
import SQLite3

var db:OpaquePointer?
let TABLE_NAME : String = "DaengDaengTable"

func databaseOpen() {
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("DaengDaengDB.sqlite")
    // 파일 경로
    print(fileURL)
    
    if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
        print("table not exsist")
    }
}

func createTable(){
    
    databaseOpen()
    
    //  title, contents, targetDate, submitDate, deleteDate
    let CREATE_QUERY_TEXT : String = "CREATE TABLE IF NOT EXISTS \(TABLE_NAME) (no INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, contents TEXT, targetDate TEXT NOT NULL, submitDate TEXT, deleteDate TEXT)"
    
    if sqlite3_exec(db, CREATE_QUERY_TEXT, nil, nil, nil) != SQLITE_OK {
        let errMsg = String(cString:sqlite3_errmsg(db))
        print("db table create error : \(errMsg)")
    }
}

func insert(_ title : String,_ contents : String, _ targetDate : String, _ submitDate : String) -> Bool{
    var stmt : OpaquePointer?
    databaseOpen()
    
    let strTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
    let strContents = contents.trimmingCharacters(in: .whitespacesAndNewlines)
    let strTargetDate = targetDate.trimmingCharacters(in: .whitespacesAndNewlines)
    let strSubmitDate = submitDate.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let INSERT_QUERY_TEXT : String = "INSERT INTO \(TABLE_NAME) (title, contents, targetDate, submitDate) Values (?,?,?,?)"
    
    if sqlite3_prepare(db, INSERT_QUERY_TEXT, -1, &stmt, nil) != SQLITE_OK {
        let errMsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing insert:v1 \(errMsg)")
        return false
    }
    
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    if sqlite3_bind_text(stmt, 1, strTitle, -1, SQLITE_TRANSIENT) != SQLITE_OK{
        let errMsg = String(cString : sqlite3_errmsg(db)!)
        print("failture binding title: \(errMsg)")
        return false
    }
    
    if sqlite3_bind_text(stmt, 2, strContents, -1, SQLITE_TRANSIENT) != SQLITE_OK{
        let errMsg = String(cString : sqlite3_errmsg(db)!)
        print("failture binding content: \(errMsg)")
        return false
    }
    
    
    if sqlite3_bind_text(stmt, 3, strTargetDate, -1, SQLITE_TRANSIENT) != SQLITE_OK{
        let errMsg = String(cString : sqlite3_errmsg(db)!)
        print("failture binding target: \(errMsg)")
        return false
    }
    
    if sqlite3_bind_text(stmt, 4, strSubmitDate, -1, SQLITE_TRANSIENT) != SQLITE_OK{
        let errMsg = String(cString : sqlite3_errmsg(db)!)
        print("failture binding submit: \(errMsg)")
        return false
    }
    
    if sqlite3_step(stmt) != SQLITE_DONE {
        let errMsg = String(cString : sqlite3_errmsg(db)!)
        print("insert fail :: \(errMsg)")
        return false
    }
    return true
}

func update(_ no:String, _ title : String,_ contents : String, _ targetDate : String) -> Bool{
    
    databaseOpen()
    
    let strNo = title.trimmingCharacters(in: .whitespacesAndNewlines)
    let strTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
    let strContents = contents.trimmingCharacters(in: .whitespacesAndNewlines)
    let strTargetDate = targetDate.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let UPDATE_QUERY = "UPDATE \(TABLE_NAME) Set title = '\(strTitle)', contents = '\(strContents)', targetDate= '\(strTargetDate)' WHERE no = \(strNo)"
    var stmt:OpaquePointer?
    print(UPDATE_QUERY)
    if sqlite3_prepare(db, UPDATE_QUERY, -1, &stmt, nil) != SQLITE_OK{
        let errMsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing update: v1\(errMsg)")
        return false
    }
    
    if sqlite3_step(stmt) != SQLITE_DONE {
        let errMsg = String(cString : sqlite3_errmsg(db)!)
        print("update fail :: \(errMsg)")
        return false
    }
    
    sqlite3_finalize(stmt)
    print("update success")
    return true
}

func delete(_ no:String, _ deleteDate:String) -> Bool{
    
    databaseOpen()
    
    let strNo = no.trimmingCharacters(in: .whitespacesAndNewlines)
    let strdeleteDate = deleteDate.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let DELETE_QUERY = "UPDATE \(TABLE_NAME) Set deleteDate = '\(strdeleteDate)' WHERE no = \(strNo)"
    var stmt:OpaquePointer?
    
    print(DELETE_QUERY)
    if sqlite3_prepare_v2(db, DELETE_QUERY, -1, &stmt, nil) != SQLITE_OK{
        let errMsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing delete: v1\(errMsg)")
        return false
    }
    
    if sqlite3_step(stmt) != SQLITE_DONE {
        let errMsg = String(cString : sqlite3_errmsg(db)!)
        print("delete fail :: \(errMsg)")
        return false
    }
    sqlite3_finalize(stmt)
    print("delete success")
    return true
}

func selectValue(_ targetDate : String){
    
    databaseOpen()
    
    // 초기 작업 필요: 데이터 지워주기 어디서 하징
//    studentsList.removeAll()
    let strTargetDate = targetDate.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let SELECT_QUERY = "SELECT * FROM \(TABLE_NAME) WHERE targetDate= '\(strTargetDate)' AND deleteDate IS NULL"
    var stmt:OpaquePointer?
    
    if sqlite3_prepare(db, SELECT_QUERY, -1, &stmt, nil) != SQLITE_OK{
        let errMsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing insert: v1\(errMsg)")
        return
    }
    
    while(sqlite3_step(stmt) == SQLITE_ROW){
        let no = sqlite3_column_int(stmt, 0)
        let title = String(cString: sqlite3_column_text(stmt, 1))
        let contents = String(cString: sqlite3_column_text(stmt, 2))
        let targetDate = String(cString: sqlite3_column_text(stmt, 3))
        let submitDate = String(cString: sqlite3_column_text(stmt, 4))
        print("read value no : \(no) title : \(title) contents : \(contents) targetDate : \(targetDate) submitDate : \(submitDate) ")
    }
}