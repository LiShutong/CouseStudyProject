//
//  lessonModel.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/17.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit

class LessonModel: NSObject {
    //lessonModel
    var videoName :String?
    var videoTitle: String? = ""
    var subtitle: String? = ""
    var japanContent: String? = ""
    var chineseContent: String? = ""
    var grade :String? = ""
    static func lessonModelWithDic(dic :Dictionary<String, String>) -> LessonModel {
        let model = LessonModel.init()
        model.videoName = dic["videoName"]
        model.videoTitle = dic["videoTitle"]
        model.subtitle = dic["subtitle"]
        model.japanContent = dic["japanContent"]
        model.chineseContent = dic["chineseContent"]
        model.grade = dic["grade"]
        return model
    }
}

