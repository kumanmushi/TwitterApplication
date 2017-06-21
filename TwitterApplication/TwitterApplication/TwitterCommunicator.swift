//
//  TwitterCommunicator.swift
//  TwitterApplication
//
//  Created by 村田真矢 on 2017/06/20.
//  Copyright © 2017年 村田真矢. All rights reserved.
//

import Social

struct TwitterCommunicator {
    func getTimeline(handler: @escaping (Data?, Error?) -> ()) {
        let request = SLRequest(
            forServiceType: SLServiceTypeTwitter,
            requestMethod: .GET,
            url: URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"),
            parameters: nil
        )
        
        request?.account = Account.twitterAccount
        
        request?.perform { data, response, error in
            if let error = error {
                handler(nil, error)
                return
            }
            
            handler(data, error)
        }
    }
}
