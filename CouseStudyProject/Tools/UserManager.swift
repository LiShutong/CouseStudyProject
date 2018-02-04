//
//  UserManager.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/19.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit

class UserManager: NSObject {
    
    static func checkLogin() -> Bool  {
        let account = UserDefaults.standard.object(forKey: "account")
        if account != nil {
            return true
        }
        return false
    }
    static func loginWithAccount(account:String, password:String) {
        UserDefaults.standard.set(account, forKey: "account")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.synchronize()
    }
    static func userWithGrade(grade :String?) {
        var grade1 = grade
        if grade1 == nil {
            grade1 = ""
        }
        UserDefaults.standard.set(grade1, forKey: "grade")
        UserDefaults.standard.synchronize()
    }
    static func loginOut() {
        UserDefaults.standard.set(nil, forKey: "account")
        UserDefaults.standard.set(nil, forKey: "password")
        UserDefaults.standard.set(nil, forKey: "grade")
        UserDefaults.standard.synchronize()
    }
    static func getLoginUser() -> UserModel {
        let account = UserDefaults.standard.object(forKey: "account")
        let password = UserDefaults.standard.object(forKey: "password")
        let grade = UserDefaults.standard.object(forKey: "grade")
        let userModel = UserModel.init()
        userModel.userAccount = account as? String
        userModel.userPassword = password as? String
        userModel.userGrade = grade as? String
        return userModel
    }
}


