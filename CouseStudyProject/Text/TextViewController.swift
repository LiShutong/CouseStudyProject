//
//  TextViewController.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/15.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    var isText :Bool = false
    var correct :Int = 0
    
    
    var dicArray :NSArray?
    var modelArray :NSMutableArray?
    var dataModel :TextModel?
    var num :intmax_t = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        initViewContent()
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
    }
    @IBOutlet weak var ABtn: UIButton!
    @IBOutlet weak var BBtn: UIButton!
    @IBOutlet weak var CBtn: UIButton!
    @IBOutlet weak var DBtn: UIButton!
    
    @IBAction func ABtnClick(_ sender: Any) {
        correctLabel.isHidden = false
        checkAnswer(answer: "A")
    }
    @IBAction func BBtnClick(_ sender: Any) {
        correctLabel.isHidden = false
         checkAnswer(answer: "B")
    }
    @IBAction func CBtnClick(_ sender: Any) {
        correctLabel.isHidden = false
         checkAnswer(answer: "C")
    }
    @IBAction func DBtnClick(_ sender: Any) {
        correctLabel.isHidden = false
         checkAnswer(answer: "D")
    }
    @IBAction func nextBtnClick(_ sender: Any) {
        num = num + 1
        if num + 1 > (modelArray?.count)! {
            nextBtn.isEnabled = false
            PromptInfo.showText("This is last one")
            if isText {
                saveGradeData()
            }
        } else {
            dataModel = modelArray?[num] as! TextModel
            initViewContent()
        }
    }
    func initViewContent() {
        correctLabel.isHidden = true
        let questionStr :NSString = NSString.init(format: "%d,%@",num+1,(dataModel?.question)!)
        questionLabel.text = questionStr as String
        let AAnswer :NSString = NSString.init(format: "A,%@",(dataModel?.A)!)
        let BAnswer :NSString = NSString.init(format: "B,%@",(dataModel?.B)!)
        let CAnswer :NSString = NSString.init(format: "C,%@",(dataModel?.C)!)
        let DAnswer :NSString = NSString.init(format: "D,%@",(dataModel?.D)!)
        ABtn.setTitle(AAnswer as String, for: .normal)
        BBtn.setTitle(BAnswer as String, for: .normal)
        CBtn.setTitle(CAnswer as String, for: .normal)
        DBtn.setTitle(DAnswer as String, for: .normal)
        let str :NSString = "The correct answer is "
        correctLabel.text = str.appending((dataModel?.correct)!)
//            dataModel?.correct
    }
    func loadData() {
        modelArray = NSMutableArray.init()
        for var dic in dicArray! {
            var model = TextModel.init()
            model = TextModel.textModelWithDic(dic: dic as! Dictionary<String, String>)
            modelArray?.add(model)
        }
        dataModel = TextModel.init()
        dataModel = modelArray![num] as? TextModel
    }
    func checkAnswer(answer :String) {
        if answer == dataModel?.correct && isText == true {
            correct = correct + 1
        }
    }
    func checkGrade(num :Int) -> String {
        if num > 4 {
            return "A"
        }
        if num >= 3 && num <= 4 {
            return "B"
        }
        return "C"
    }
    func saveGradeData() {
        let grade = checkGrade(num: correct)
        print("grade:%@",grade)
        DataBaseManager.updataUserInfoKey(key: "grade", value: grade)
        UserManager.userWithGrade(grade: grade)
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "checkLogin"), object: nil)
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
