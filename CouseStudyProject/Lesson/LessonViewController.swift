//
//  LessonViewController.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/15.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeigh = UIScreen.main.bounds.size.height

class LessonViewController: UIViewController, MHAVPlayerSDKDelegate {
    var mhPlayer: MHAVPlayerSDK?
    var playerTitle :String?
    var dicArray :NSArray?
    var textView :UITextView!
    var modelArray :NSMutableArray?
    var datamodel :LessonModel?
    var num :intmax_t = 0
    var nextBtn :UIButton?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        loadData()
        initPlayer()
        initUI()
    }
    func initPlayer() {
        playerTitle = (datamodel?.subtitle)!
        let videoName :String = (datamodel?.videoName)!
        let testDataPath = Bundle.main.bundleURL.appendingPathComponent(videoName)
        mhPlayer = MHAVPlayerSDK(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeigh / 2 - 64))
        mhPlayer?.mhPlayerURL = testDataPath.path
        mhPlayer?.mhPlayerTitle = playerTitle
        mhPlayer?.MHAVPlayerSDKDelegate = self
        mhPlayer?.mhLastTime = 0
        mhPlayer?.mhAutoOrient = false
        view.addSubview(mhPlayer!)
    }
    func initUI() {
        let languangeSelectSegment = UISegmentedControl.init(frame: CGRect (x: 20, y:ScreenHeigh / 2 + 1, width: 200, height: 30))
        languangeSelectSegment.backgroundColor = UIColor.white
        languangeSelectSegment.tintColor = UIColor.blue
        languangeSelectSegment.selectedSegmentIndex = 0
        languangeSelectSegment.insertSegment(withTitle: "日文", at: 0, animated: true)
        languangeSelectSegment.insertSegment(withTitle: "中文", at: 1, animated: true)
        languangeSelectSegment.addTarget(self, action: #selector(LessonViewController.segmentValueChange), for: UIControlEvents.valueChanged)
        view.addSubview(languangeSelectSegment)
        
        nextBtn = UIButton.init(frame: CGRect(x: view.frame.size.width - 100, y:ScreenHeigh / 2 + 1, width: 50, height: 30))
        nextBtn?.addTarget(self, action: #selector(LessonViewController.nextBtnClick), for: UIControlEvents.touchUpInside )
        nextBtn?.backgroundColor = UIColor.blue
        nextBtn?.setTitleColor(UIColor.white, for: .normal)
        nextBtn?.setTitle("next", for: .normal)
        view.addSubview(nextBtn!)
        
        textView = UITextView.init(frame: CGRect (x: 0, y:ScreenHeigh/2 + 32, width: ScreenWidth, height: ScreenHeigh/2 - 78))
        textView.backgroundColor = UIColor.white
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(textView)
    }
    func segmentValueChange(_ segment: UISegmentedControl) {
        initTextViewContent(num: segment.selectedSegmentIndex)
    }
    func initTextViewContent(num :intmax_t) {
        if num == 0 {
            textView.text = datamodel?.japanContent
        } else {
            textView.text = datamodel?.chineseContent
        }
    }
    func nextBtnClick()  {
        mhPlayer?.MHAVPlayerSDKDelegate = nil
        num = num + 1
        if num + 1 > (modelArray?.count)! {
            nextBtn?.isEnabled = false
             PromptInfo.showText("This is last one")
        } else {
            datamodel = modelArray![num] as? LessonModel
            mhPlayer?.mhStopPlayer()
            initPlayer()
            textView.text = ""
        }
        
    }
    func loadData() {
        modelArray = NSMutableArray.init()
        for var dic in dicArray! {
            var lessonModel = LessonModel.init()
            lessonModel = LessonModel.lessonModelWithDic(dic: dic as! Dictionary<String, String>)
            modelArray?.add(lessonModel)
        }
        datamodel = LessonModel.init()
        datamodel = modelArray![num] as? LessonModel
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        mhPlayer?.mhStopPlayer()
        mhPlayer = nil
        mhPlayer?.MHAVPlayerSDKDelegate = nil
        view.removeFromSuperview()
    }
}
extension ViewController: MHAVPlayerSDKDelegate {
    
    
        func mhNextPlayer() {
        }
    
}




            

