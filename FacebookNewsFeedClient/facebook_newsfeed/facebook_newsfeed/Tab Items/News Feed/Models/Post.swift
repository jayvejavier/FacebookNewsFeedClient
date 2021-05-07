//
//  Post.swift
//  facebook_newsfeed
//
//  Created by Mospeng Research Lab Philippines on 6/14/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import Foundation

class Post: NSObject {
    @objc var name: String?
    @objc var profileImageName: String?
    @objc var statusText: String?
    @objc var statusImageName: String?
    @objc var numLikes: NSNumber?
    @objc var numComments: NSNumber?
    @objc var statusImageUrl: String?
    
    @objc var location: Location?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "location" {
            location = Location()
            location?.setValuesForKeys(value as! [String : Any])
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
    
    //paused at 10:00
}
