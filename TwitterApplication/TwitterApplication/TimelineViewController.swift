//
//  TimelineViewController.swift
//  TwitterApplication
//
//  Created by 村田真矢 on 2017/06/20.
//  Copyright © 2017年 村田真矢. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // テーブル表示用のデータソース
    var tweets: [Tweet] = []
    
var loginClosure: (Bool) -> () = { isSuccess in
    switch isSuccess {
    case false:
        print("ログイン失敗")
    case true:
        print("ログイン成功")
    }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        LoginCommunicator().login() { isSuccess in
            switch isSuccess {
            case false:
                print("ログイン失敗")
            case true:
                print("ログイン成功")
                
            TwitterCommunicator().getTimeline() { [weak self] data, error in
                
                if let error = error {
                    print(error)
                    return
                }
                
                let timelineParser = TimelineParser()
                let tweets = timelineParser.parse(data: data!)
                print(tweets)
                    
                self?.tweets = tweets
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TimelineViewController: UITableViewDelegate {
    
    // cellがタップされたのを検知したときに実行する処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルがタップされたよ！")
    }
    
    // セルの見積もりの高さを指定する処理
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // セルの高さ指定をする処理
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // UITableViewCellの高さを自動で取得する値
        return UITableViewAutomaticDimension
    }
}

extension TimelineViewController: UITableViewDataSource {
    // 何個のcellを生成するかを設定する関数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // tweetsの配列内の要素数分を指定
        return tweets.count
    }
    
    // 描画するcellを設定する関数
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TweetTableViewCellを表示したいので、TweetTableViewCellを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell") as! TweetTableViewCell
        
        // TweetTableViewCellの描画内容となるtweetを渡す
        cell.fill(tweet: tweets[indexPath.row])
        
        return cell
    }
}
