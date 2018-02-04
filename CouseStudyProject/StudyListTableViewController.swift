//
//  StudyListTableViewController.swift
//  CouseStudyProject
//
//  Created by 李书通 on 2018/1/15.
//  Copyright © 2018年 李书通. All rights reserved.
//

import UIKit

class StudyListTableViewController: UITableViewController  {
    let dataArray = ["第1課　インターネット",
                     "第2課　新型コンピュータウィルス",
                     "第3課　顔認証支払いシステム",
                     "第4課　モータの原理",
                     "第5課　超伝導技術による省エネルギー化",
                     "第6課　量子暗号通信",
                     "第7課　クリーンエネルギー",
                     "第8課　新型ディスプレイとOLED技術",
                     "第9課　生体ロボティックス",
                     "第10課　DNAの解析とライブラリ化",
                     "第11課　ハイパーループにおけるエアシューターの解決技術",
                     "第12課　宇宙溶接技術",
                     "第13課　地震速報ネットワーク",
                     "第14課　漢方の美容効果"]
    var forteenLessonArray :NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.tableView.delegate = self;
        self.tableView.dataSource = self
        self.navigationItem.title = "レッスンリスト"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier :NSString = "TableViewCell"
        var tableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier as String)
        if tableViewCell == nil {
            tableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier as String)
        }
        tableViewCell?.textLabel?.text = dataArray[indexPath.row]
        return tableViewCell!
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studyContentArray :NSArray = forteenLessonArray![indexPath.row] as! NSArray
        if studyContentArray.count > 0 {
            let studyContenVc = StudyContentViewController.init();
            studyContenVc.navigationItem.title = dataArray[indexPath.row]
            studyContenVc._tag = indexPath.row
            studyContenVc.isPersonalStudy = false
            self.navigationController?.pushViewController(studyContenVc, animated: true)
        } else {
            PromptInfo.showText("There is no content in this course")
        }
    }
    func loadData() {
        let path = Bundle.main.path(forResource: "data", ofType: "plist")
        forteenLessonArray = NSArray.init(contentsOfFile: path!)!
    }

}
