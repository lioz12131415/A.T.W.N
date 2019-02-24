//
//  UsersArticles.swift
//  A.T.W.N
//
//  Created by lioz balki on 24/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

struct PeopleSayArticles: Hashable {
    
    var hasValue: Int {
        return id.hashValue
    }
    
    static func == (lhs: PeopleSayArticles, rhs: PeopleSayArticles) -> Bool {
        return lhs.id == rhs.id
    }

    var id: String?
    var sortBy: Int?
    var title: String?
    var author: String?
    var category: String?
    var urlToImage: String?
    var description: String?
    var timeInterval: Double?
    var profileImage: String?
    
    var type = "peopleSayArticles"
}

extension PeopleSayArticles {
    static func setArticles(with dict: dictionary) -> PeopleSayArticles {
     var peopleSayArticles = PeopleSayArticles()
        
        peopleSayArticles.id =  dict["id"] as? String
        peopleSayArticles.title = dict["title"] as? String
        peopleSayArticles.author = dict["author"] as? String
        peopleSayArticles.category = dict["category"] as? String
        peopleSayArticles.urlToImage = dict["urlToImage"] as? String
        peopleSayArticles.description = dict["description"] as? String
        peopleSayArticles.timeInterval = dict["timeInterval"] as? Double
        peopleSayArticles.profileImage = dict["profileImage"] as? String
        
        return peopleSayArticles
    }
}
