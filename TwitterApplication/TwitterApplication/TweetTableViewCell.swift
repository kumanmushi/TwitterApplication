//
//  TweetTableViewCell.swift
//  TwitterApplication
//
//  Created by 村田真矢 on 2017/06/20.
//  Copyright © 2017年 村田真矢. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!
    
    func fill(tweet: Tweet) {
        // profileImageURLから画像をダウンロードしてくる処理
        let downloadTask = URLSession.shared.dataTask(with: URL(string: tweet.user.profileImageURL)!) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                // iconImageViewにダウンロードしてきた画像を代入する処理
                self?.iconImageView.image = UIImage(data: data!)
            }
        }
        downloadTask.resume()
        
        // tweetから値を取り出して、UIにセットする
        nameLabel.text = tweet.user.name
        textContentLabel.text = tweet.text
        // screenNameには "@" が含まれていないので、頭に "@" を入れてあげる必要がある
        screenNameLabel.text = "@" + tweet.user.screenName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        self.nameLabel.textColor = .white
        self.screenNameLabel.textColor = .white
        self.textContentLabel.textColor = .white
        
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.screenNameLabel.font = UIFont.italicSystemFont(ofSize: 12)
        self.textContentLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.iconImageView.clipsToBounds = true
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width / 2.0
        self.iconImageView.layer.borderColor = UIColor.white.cgColor
        self.iconImageView.layer.borderWidth = 1.0
    }
}
