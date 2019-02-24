//
//  User.swift
//  A.T.W.N
//
//  Created by lioz balki on 29/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//
    
import UIKit

class User {
    var name: String?
    var profileImage: String?
    var currentEmail: String?
   
    static var user = User()
    //var articles: [PeopleSayArticles]?
    //var saveArticle: [PeopleSayArticles]?
    //var savePeopleSayArticles: [Articles]?
}

extension User {
    static func setUser(with dict: dictionary) {
        self.user.name = dict["name"] as? String
        self.user.profileImage = dict["profileImage"] as? String
        self.user.currentEmail = dict["currentEmail"] as? String
    }
}

extension User {
    static func setStaticUser(with user: User) {
        self.user.name = user.name
        self.user.profileImage = user.profileImage
        self.user.currentEmail = user.currentEmail
    }
}
