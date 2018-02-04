//
//  wordModel.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/18.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit


class WordModel: NSObject {
    //wordModel
    var title :String?
    var translation: String? = ""
    var read: String? = ""
    var exampleSentence: String? = ""
    var imageName: String? = ""
    var grade :String? = ""
    static func wordModelWithDic(dic :Dictionary<String, String>) -> WordModel {
        let model = WordModel.init()
        model.title = dic["title"]
        model.translation = dic["translation"]
        model.read = dic["read"]
        model.exampleSentence = dic["exampleSentence"]
        model.imageName = dic["imageName"]
         model.grade = dic["grade"]
        return model
    }
}
