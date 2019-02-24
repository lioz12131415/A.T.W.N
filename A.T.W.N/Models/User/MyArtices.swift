//
//  MyArtices.swift
//  A.T.W.N
//
//  Created by lioz balki on 23/02/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

class MyArticles {
    
    var id: String?
    var title: String?
    var author: String?
    var category: String?
    var urlToImage: String?
    var description: String?
    var profileImage: String?
    var timeInterval: Double?
    
    static var myArticlesArr = [MyArticles]()
}

extension MyArticles {
    static func setMyArticles(with dict: dictionary) {
        let myArticles = MyArticles()
        
        myArticles.id = dict["id"] as? String
        myArticles.title = dict["title"] as? String
        myArticles.author = dict["author"] as? String
        myArticles.category = dict["category"] as? String
        myArticles.urlToImage = dict["urlToImage"] as? String
        myArticles.description = dict["description"] as? String
        myArticles.profileImage = dict["profileImage"] as? String
        myArticles.timeInterval = dict["timeInterval"] as? Double
        
        myArticlesArr.append( myArticles )
    }
}
