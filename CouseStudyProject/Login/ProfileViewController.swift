//
//  ProfileViewController.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/20.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var account :UITextField?
    var password :UITextField?
    var grade :UITextField?
    var changeBtn :UIButton?
    var textBtn :UIButton?
    var isChange :Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        checkLogin()
        NotificationCenter.default.addObserver(self, selector:#selector(checkContent), name:NSNotification.Name(rawValue: "checkLogin"), object: nil)
        
        
        // Do any additional setup after loading the view.
    }
    
    func initUI(){
        self.title = "Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Logout",
                                                                      style: .plain,
                                                                      target:self,
                                                                      action: #selector(rightBarBtnItemClick))
        
        view.backgroundColor = UIColor.white
        account = UITextField.init(frame: CGRect.init(x: 50, y: 100, width: view.frame.size.width - 100, height: 40))
        account?.placeholder = "account"
        account?.isEnabled = false
        let line1 = UIView.init(frame: CGRect.init(x: (account?.frame.origin.x)!, y: (account?.frame.origin.y)!
            + (account?.frame.size.height)!, width: (account?.frame.size.width)!, height: 1))
        line1.backgroundColor = UIColor.gray
        view.addSubview(line1)
        view.addSubview(account!)
        
        password = UITextField.init(frame: CGRect.init(x: (account?.frame.origin.x)!, y: (account?.frame.origin.y)! + (account?.frame.size.height)! + 20, width: (account?.frame.size.width)!, height: 40))
        password?.placeholder = "passWord"
        password?.isEnabled = false
        let line2 = UIView.init(frame: CGRect.init(x: (password?.frame.origin.x)!, y: (password?.frame.origin.y)!
            + (password?.frame.size.height)!, width: (password?.frame.size.width)!, height: 1))
        line2.backgroundColor = UIColor.gray
        view.addSubview(line2)
        view.addSubview(password!)
        
        
        grade = UITextField.init(frame: CGRect.init(x: (password?.frame.origin.x)!, y: (password?.frame.origin.y)! + (password?.frame.size.height)! + 20, width: (password?.frame.size.width)!, height: 40))
        grade?.placeholder = "grade"
        grade?.isEnabled = false
        let line3 = UIView.init(frame: CGRect.init(x: (grade?.frame.origin.x)!, y: (grade?.frame.origin.y)!
            + (grade?.frame.size.height)!, width: (grade?.frame.size.width)!, height: 1))
        line3.backgroundColor = UIColor.gray
        view.addSubview(line3)
        view.addSubview(grade!)
        
        changeBtn = UIButton.init(type: .system)
        changeBtn = UIButton.init(frame: CGRect.init(x: 50, y: (grade?.frame.origin.y)!
            + (grade?.frame.size.height)! + 20, width: (grade?.frame.size.width)!, height: 40))
        changeBtn?.addTarget(self, action: #selector(changeBtnClick), for: UIControlEvents.touchUpInside)
        changeBtn?.setTitle("ChangeData", for: .normal)
        changeBtn?.backgroundColor = UIColor.lightGray
        changeBtn?.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(changeBtn!)
        
        textBtn = UIButton.init(type: .system)
        textBtn = UIButton.init(frame: CGRect.init(x: 50, y: (changeBtn?.frame.origin.y)!
            + (changeBtn?.frame.size.height)! + 20, width: (changeBtn?.frame.size.width)!, height: 40))
        textBtn?.addTarget(self, action: #selector(textBtnClick), for: UIControlEvents.touchUpInside)
        textBtn?.setTitle("Text", for: .normal)
        textBtn?.backgroundColor = UIColor.lightGray
        textBtn?.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(textBtn!)
        
        
        checkContent()
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    func changeBtnClick() {
        if !isChange {
            isChange = true
            account?.isEnabled = true
            password?.isEnabled = true
            changeBtn?.setTitle("SaveData", for: .normal)
        } else {
            isChange = false
            account?.isEnabled = false
            password?.isEnabled = false
            changeBtn?.setTitle("ChangeData", for: .normal)
            if account?.text != nil && password?.text != nil {
                let userModel = UserModel.init()
                userModel.userAccount = account?.text
                userModel.userPassword = password?.text
                DataBaseManager.updataUserInfoKey(key: "account", value: userModel.userAccount!)
                DataBaseManager.updataUserInfoKey(key: "password", value: userModel.userPassword!)
                UserManager.loginWithAccount(account: userModel.userAccount!, password: userModel.userPassword!)
            } else {
                print("Incomplete information")
                PromptInfo.showText("Incomplete information")
            }
        }
    }
    func textBtnClick() {
        let textVC = TextViewController.init()
        self.hidesBottomBarWhenPushed = true
        textVC.isText = true
        textVC.dicArray = initTextData()
        self.navigationController?.pushViewController(textVC, animated: true)

    }
    func initTextData() ->NSArray {
        let path = Bundle.main.path(forResource: "Question", ofType: "plist")
        let array = NSArray.init(contentsOfFile: path!)
        let randomSet = NSMutableSet.init()
        while randomSet.count < 5 {
            let r = Int(arc4random()) % (array?.count)!
            randomSet.add(array?.object(at: r) as Any)
        }
        let randomArray:NSArray = randomSet.allObjects as NSArray
        return randomArray
    }

    func hideKeyBoard() {
        view.endEditing(true)
    }
    func rightBarBtnItemClick()  {
        UserManager.loginOut()
        checkLogin()
    }
    func checkContent() {
        let usermodel = UserManager.getLoginUser()
        account?.text = usermodel.userAccount
        grade?.text = usermodel.userGrade
        password?.text = usermodel.userPassword
    }
    func checkLogin() {
        if !UserManager.checkLogin() {
            let loginVC = LoginViewController.init()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        checkContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
