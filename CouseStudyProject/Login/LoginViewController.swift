//
//  LoginViewController.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/18.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var account :UITextField?
    var password :UITextField?
    var loginBtn :UIButton?
    var registerBtn :UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    func initUI() {
        view.backgroundColor = UIColor.white
        self.title = "Login"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        
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
        
        loginBtn = UIButton.init(type: .system)
        loginBtn = UIButton.init(frame: CGRect.init(x: 50, y: (password?.frame.origin.y)!
            + (password?.frame.size.height)! + 20, width: (password?.frame.size.width)!, height: 40))
        loginBtn?.addTarget(self, action: #selector(loginBtnClick), for: UIControlEvents.touchUpInside)
        loginBtn?.setTitle("LOGIN", for: .normal)
        loginBtn?.backgroundColor = UIColor.lightGray
        loginBtn?.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(loginBtn!)
        
        registerBtn = UIButton.init(type: .system)
        registerBtn = UIButton.init(frame: .init(x: 50, y: (loginBtn?.frame.origin.y)!
            + (loginBtn?.frame.size.height)! + 20, width: (password?.frame.size.width)!, height: 40))
        registerBtn?.addTarget(self, action: #selector(registerBtnClick), for: UIControlEvents.touchUpInside)
        registerBtn?.setTitle("No account yet? Create one", for: .normal)
        registerBtn?.setTitleColor(UIColor.lightGray, for: .normal)
        view.addSubview(registerBtn!)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
    }
    func back()  {
        view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    func loginBtnClick() {
        print("lst")
        if account?.text != nil && password?.text != nil {
            DataBaseManager.creatUserTable()
            let userModel = UserModel.init()
            userModel.userAccount = account?.text
            userModel.userPassword = password?.text
            if DataBaseManager.checkUser(model: userModel) {
                let model = DataBaseManager.featchUserWithUserModel(account: userModel.userAccount!, password: userModel.userPassword!)
                UserManager.loginWithAccount(account: model.userAccount!, password: model.userPassword!)
                UserManager.userWithGrade(grade: model.userGrade)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "checkLogin"), object: nil)
                self.navigationController?.popViewController(animated: true)
            } else {
                PromptInfo.showText("User not exist")
                print("User not exist")
            }
        } else {
            PromptInfo.showText("Incomplete information")
            print("Incomplete information")
        }
    }
    func registerBtnClick() {
        let registerVc = RegisterViewController.init()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(registerVc, animated: true)
    }
    func hideKeyBoard() {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
