//
//  WordViewController.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/18.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit

class WordViewController: UIViewController {

    @IBOutlet weak var wordTitle: UILabel!
    @IBOutlet weak var wordTranslation: UILabel!
    @IBOutlet weak var wordRead: UILabel!
    @IBOutlet weak var exampleSentence: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var dicArray :NSArray?
    var modelArray :NSMutableArray?
    var dataModel :WordModel?
    var num :intmax_t = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initUI
        exampleSentence.numberOfLines = 0
        exampleSentence.lineBreakMode = NSLineBreakMode.byWordWrapping
        loadData()
        initViewContent()

        // Do any additional setup after loading the view.
    }
    func initViewContent() {
        wordTitle.text = dataModel?.title
        wordTranslation.text = dataModel?.translation
        wordRead.text = dataModel?.read
        exampleSentence.text = dataModel?.exampleSentence
        imageView.image = UIImage.init(named: (dataModel?.imageName)!)
    }
    
    @IBAction func nextBtnClick(_ sender: Any) {
        num = num + 1
        if num + 1 > (modelArray?.count)! {
            nextBtn.isEnabled = false
            PromptInfo.showText("This is last one")
        } else {
            dataModel = modelArray?[num] as! WordModel
            initViewContent()
        }
    }
    
    func loadData() {
        modelArray = NSMutableArray.init()
        for var dic in dicArray! {
            var model = WordModel.init()
            model = WordModel.wordModelWithDic(dic: dic as! Dictionary<String, String>)
            modelArray?.add(model)
        }
        dataModel = WordModel.init()
        dataModel = modelArray![num] as? WordModel
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
