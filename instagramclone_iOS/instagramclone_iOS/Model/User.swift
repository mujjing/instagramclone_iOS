//
//  User.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/06/02.
//

import Foundation

struct User {
    let username: String
    let fullname: String
    let bio: String
    let image: String
    let uid: String
    
    init(username: String, fullname: String, bio: String, image: String, uid: String) {
        self.username = username
        self.fullname = fullname
        self.bio = bio
        self.image = image
        self.uid = uid
    }
}
