//
//  Tweet.swift
//  TwitterApplication
//
//  Created by 村田真矢 on 2017/06/20.
//  Copyright © 2017年 村田真矢. All rights reserved.
//

import Foundation

struct Tweet {
    
    // Tweetのid
    let id: String
    // Tweetの本文
    let text: String
    // このTweetの主
    let user: User
    
    init?(json: Any) {
        guard let dictionary = json as? [String: Any] else { return nil }
        
        guard let id = dictionary["id_str"] as? String else { return nil }
        guard let text = dictionary["text"] as? String else { return nil }
        guard let userJSON = dictionary["user"] else { return nil }
        guard let user = User(json: userJSON) else { return nil }
        
        self.id = id
        self.text = text
        self.user = user
    }
}
