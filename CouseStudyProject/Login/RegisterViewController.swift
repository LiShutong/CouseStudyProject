//
//  RegisterViewController.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/19.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    var account :UITextField?
    var password :UITextField?
    var registerBtn :UIButton?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    func initUI(){
        self.title = "Register"
        view.backgroundColor = UIColor.white
        account = UITextField.init(frame: CGRect.init(x: 50, y: 100, width: view.frame.size.width - 100, height: 40))
        account?.placeholder = "account"
        let line1 = UIView.init(frame: CGRect.init(x: (account?.frame.origin.x)!, y: (account?.frame.origin.y)!
            + (account?.frame.size.height)!, width: (account?.frame.size.width)!, height: 1))
        line1.backgroundColor = UIColor.gray
        view.addSubview(line1)
        view.addSubview(account!)
        
        password = UITextField.init(frame: CGRect.init(x: (account?.frame.origin.x)!, y: (account?.frame.origin.y)! + (account?.frame.size.height)! + 20, width: (account?.frame.size.width)!, height: 40))
        password?.placeholder = "passWord"
        let line2 = UIView.init(frame: CGRect.init(x: (password?.frame.origin.x)!, y: (password?.frame.origin.y)!
            + (password?.frame.size.height)!, width: (password?.frame.size.width)!, height: 1))
        line2.backgroundColor = UIColor.gray
        view.addSubview(line2)
        view.addSubview(password!)
        
        registerBtn = UIButton.init(type: .system)
        registerBtn = UIButton.init(frame: CGRect.init(x: 50, y: (password?.frame.origin.y)!
            + (password?.frame.size.height)! + 20, width: (password?.frame.size.width)!, height: 40))
        registerBtn?.addTarget(self, action: #selector(registerBtnClick), for: UIControlEvents.touchUpInside)
        registerBtn?.setTitle("Register", for: .normal)
        registerBtn?.backgroundColor = UIColor.lightGray
        registerBtn?.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(registerBtn!)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
        
    }
    func registerBtnClick() {
        //注册
        DataBaseManager.creatUserTable()
        if account?.text != nil {
            if DataBaseManager.isExit(account: (account?.text)!) {
                PromptInfo.showText("User already exist !")
                print("User already exist !")
                return
            }
        }
        if account?.text != nil && password?.text != nil {
            let userModel = UserModel.init()
            userModel.userAccount = account?.text
            userModel.userPassword = password?.text
//            userModel.userGrade = ""
            DataBaseManager.insertWithModel(userModel: userModel)
            PromptInfo.showText("Register Success")
            print("Register sussess")
            self.navigationController?.popViewController(animated: true)
        } else {
            PromptInfo.showText("Incomplete information")
            print("Incomplete information")
        }
        
        
    }
    func hideKeyBoard() {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
