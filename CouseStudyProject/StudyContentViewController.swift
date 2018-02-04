//
//  StudyContentViewController.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/15.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit

class StudyContentViewController: UIViewController {
    var isPersonalStudy :Bool = true
    var _tag :intmax_t? = 0
    var lessonArray :NSArray?
    var wordArray :NSArray?
    var textArray :NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        if !isPersonalStudy {
            loadData()
        } else {
            check()
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Profile", style: .plain, target: self, action: #selector(profileBtnClick))
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func lessonBtnClick(_ sender: UIButton) {
        if isPersonalStudy {
            check()
        }
        if lessonArray!.count > 0 {
            let lessonVC = LessonViewController.init()
            lessonVC.dicArray = lessonArray
            self.navigationController?.pushViewController(lessonVC, animated: true)
        }
        
    }
    
    @IBAction func wordBtnClick(_ sender: UIButton) {
        if isPersonalStudy {
            check()
        }
        if wordArray!.count > 0 {
            let wordVC = WordViewController.init()
            wordVC.dicArray = wordArray
            self.navigationController?.pushViewController(wordVC, animated: true)
        }
    }

    @IBAction func textBtnClick(_ sender: UIButton) {
        if isPersonalStudy {
            check()
        }
        if textArray!.count > 0 {
            let textVc = TextViewController.init()
            textVc.dicArray = textArray
            self.navigationController?.pushViewController(textVc, animated: true)
        }
    }
   func profileBtnClick() {
        let profileVc = ProfileViewController.init()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(profileVc, animated: true)
         self.hidesBottomBarWhenPushed = false
    }
    
    func loadData() {
        let path = Bundle.main.path(forResource: "data", ofType: "plist")
        let array0 :NSArray = NSArray.init(contentsOfFile: path!)!
        let array1 :NSArray = array0[_tag!] as! NSArray
        lessonArray = array1[0] as! NSArray
        wordArray  = array1[1] as! NSArray
        textArray = array1[2] as! NSArray
    }
    func loadPersonalData() {
        
        let path = Bundle.main.path(forResource: "data", ofType: "plist")
        let array0 :[NSArray] = NSArray.init(contentsOfFile: path!)! as! [NSArray] //14门课程
        
        let model = UserManager.getLoginUser()
        let grade = model.userGrade
        var lessonMA = NSMutableArray.init()
        var wordMA = NSMutableArray.init()
        var textMA = NSMutableArray.init()
        for var array1 in array0 {
            if array1.count == 0 {
                continue
            }
            let lessonDicArray = array1[0] as! NSArray
            for var dic in lessonDicArray {
                let tempLessonModel = LessonModel.lessonModelWithDic(dic: dic as! Dictionary<String, String>)
                if tempLessonModel.grade == grade {
                    lessonMA.add(dic)
                }
            }
            let wordDicArray  = array1[1] as! NSArray
            for var dic in wordDicArray {
                let tempWordModel = WordModel.wordModelWithDic(dic: dic as! Dictionary<String, String>)
                if tempWordModel.grade == grade {
                    wordMA.add(dic)
                }
            }
            let textDicArray = array1[2] as! NSArray
            for var dic in textDicArray {
                let tempTextModel = TextModel.textModelWithDic(dic: dic as! Dictionary<String, String>)
                if tempTextModel.grade == grade {
                    textMA.add(dic)
                }
            }
        }
        lessonArray = lessonMA
        wordArray  = wordMA
        textArray = textMA
    }
    func check()  {
        if !UserManager.checkLogin() {
            checkLogin()
        }
        let userModel = UserManager.getLoginUser()
        if userModel.userGrade == "" {
            textBtnClick()
        }
        loadPersonalData()
    }
    func checkLogin() {
        if !UserManager.checkLogin() {
            PromptInfo.showText("Please log in")
            let loginVC = LoginViewController.init()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(loginVC, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
    }
    func textBtnClick() {
        PromptInfo.showText("Please do a test first")
        let textVC = TextViewController.init()
        self.hidesBottomBarWhenPushed = true
        textVC.isText = true
        textVC.dicArray = initTextData()
        self.navigationController?.pushViewController(textVC, animated: true)
        self.hidesBottomBarWhenPushed = false
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
