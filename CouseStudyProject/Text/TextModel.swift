//
//  TextModel.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/18.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit
class TextModel: NSObject {
    //wordModel
    var question :String?
    var correct: String? = ""
    var A: String? = ""
    var B: String? = ""
    var C: String? = ""
    var D: String? = ""
    var grade :String? = ""
    
    static func textModelWithDic(dic :Dictionary<String, String>) -> TextModel {
        let model = TextModel.init()
        model.question = dic["question"]
        model.correct = dic["correct"]
        model.A = dic["A"]
        model.B = dic["B"]
        model.C = dic["C"]
        model.D = dic["D"]
        model.grade = dic["grade"]
        return model
    }
}
