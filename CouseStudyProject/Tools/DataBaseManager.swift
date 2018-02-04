//
//  DataBaseManager.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/19.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit

let dbPath :NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
let dbFileName :NSString = dbPath.appendingPathComponent("user.sqlite") as NSString

class DataBaseManager: NSObject {
    static func creatUserTable() {
        let db = FMDatabase.init(path: dbFileName as String!)
        if  (db?.open())!{
            let SQLString :String = "create table if not exists t_user(account text PRIMARY KEY, password text, grade text)"
            let result = db?.executeUpdate(SQLString, withArgumentsIn: nil)
            if result! {
                NSLog("create usertable success")
            }
        }
        db?.close()
    }
    static func insertWithModel(userModel :UserModel) {
        print("insert == %@,%@,%@", userModel.userAccount as Any, userModel.userPassword as Any, userModel.userGrade as Any)
        let db = FMDatabase.init(path: dbFileName as String!)
        if  (db?.open())!{
            let SQLString :String = "insert into t_user(account,password) values(?,?)"
            let result = db?.executeUpdate(SQLString, withArgumentsIn: [userModel.userPassword as Any, userModel.userPassword as Any])
            if result! {
                print("insert success")
            }else{
                print("error:%d    %@",result as Any,db?.lastErrorMessage as Any);
            }
        }
        db?.close()
        
    }
    
    static func featchAllUser() -> NSArray {
        let db = FMDatabase.init(path: dbFileName as String!)
        let featchResult = NSMutableArray.init()
         if  (db?.open())!{
            let SQLString :String = "SELECT * FROM t_user"
            let result = db?.executeQuery(SQLString, withArgumentsIn: nil)
            while result?.next() != nil {
                let account = result?.string(forColumn: "account")
                let password = result?.string(forColumn: "password")
                let grade = result?.string(forColumn: "grade")
                
                let model = UserModel.init()
                model.userAccount = account
                model.userGrade = grade
                model.userPassword = password
                featchResult.add(model)
            }
        }
        db?.close()
        return featchResult
    }
    static func isExit(account :String) -> Bool {
        let db = FMDatabase.init(path: dbFileName as String!)
        var exist = false
        if  (db?.open())!{
            let SQLString :String = "SELECT * FROM t_user where account = ?"
            let result = db?.executeQuery(SQLString, withArgumentsIn: [account])
            if result?.next() == true {
                exist = true
            } else {
                exist = false
            }
        }
        db?.close()
        return exist
    }
    static func checkUser(model :UserModel) -> Bool {
        let db = FMDatabase.init(path: dbFileName as String!)
        var exist = false
        if  (db?.open())!{
            let SQLString :String = "SELECT * FROM t_user where account = ? and password = ?"
            let result = db?.executeQuery(SQLString, withArgumentsIn: [model.userAccount as Any, model.userPassword as Any])
            if result?.next() == true {
                exist = true
            } else {
                exist = false
            }
        }
        db?.close()
        return exist
    }
    
    static func featchUserWithUserModel(account:String, password:String) -> UserModel {
        let db = FMDatabase.init(path: dbFileName as String!)
        var model = UserModel .init()
        if  (db?.open())!{
            let SQLString :String = "SELECT * FROM t_user where account = ? and password = ?"
            let result = db?.executeQuery(SQLString, withArgumentsIn: [account, password])
            if result?.next() == true {
                let account1 = result?.string(forColumn: "account")
                let password1 = result?.string(forColumn: "password")
                let grade1 = result?.string(forColumn: "grade")
                let userModel = UserModel.init()
                userModel.userAccount = account1
                userModel.userPassword = password1
                userModel.userGrade = grade1
                model = userModel
            }
        }
        db?.close()
        return model
    }
    static func updataUserInfoKey(key :String, value :String) {
        let userModel = UserManager.getLoginUser()
        let db = FMDatabase.init(path: dbFileName as String!)
        if  (db?.open())!{
            let SQLString = NSString.init(format: "update t_user set %@=? where account=%@ and password=%@", key, userModel.userAccount!, userModel.userPassword!)
            let result = db?.executeUpdate(SQLString as String!, withArgumentsIn: [value])
            if result! {
                print("update success")
            }else{
                print("update fail");
            }
        }
        db?.close()
    }
}


