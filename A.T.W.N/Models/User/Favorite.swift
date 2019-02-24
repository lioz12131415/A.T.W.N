//
//  Favorite.swift
//  A.T.W.N
//
//  Created by lioz balki on 10/02/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

struct Favorite {
    
    typealias FavoriteArr = Array< Any >
    static var delegate: FavoriteDelegate?
    static var favoriteArr: FavoriteArr = []

}


extension Favorite {
    static func article(_ a: Any) -> Articles? {
        guard let aArticle = a as? Articles else { return nil }
            return aArticle
    }
    
    static func peopleSayArticle(_ p: Any) -> PeopleSayArticles? {
        guard let aPeopleSayArticle = p as? PeopleSayArticles else { return nil}
            return aPeopleSayArticle
    }
}

extension Favorite {
    static func setData(with dict: dictionary, callback: @escaping() -> Void) {
       
        var a = Articles()
        var p = PeopleSayArticles()
        
        guard let type = dict["type"] as? String else { return }
        
        if type == "peopleSayArticles" {
            
            p.id =  dict["id"] as? String
            p.sortBy = dict["sortBy"] as? Int
            p.title = dict["title"] as? String
            p.author = dict["author"] as? String
            p.category = dict["category"] as? String
            p.urlToImage = dict["urlToImage"] as? String
            p.description = dict["description"] as? String
            p.timeInterval = dict["timeInterval"] as? Double
            p.profileImage = dict["profileImage"] as? String
            
            let i = (p.sortBy ?? 0) - favoriteArr.count
            favoriteArr.insert(p, at: i)//append(p as Any)
        } else {
            
            a.sortBy = dict["sortBy"] as? Int
            a.title = dict["title"] as? String
            a.author = dict["author"] as? String
            a.urlToImage = dict["urlToImage"] as? String
            a.publishedAt = dict["publishedAt"] as? String
            a.description = dict["description"] as? String
            a.url = URL(string: dict["url"] as? String ?? "")
            
            let i = (a.sortBy ?? 0) - favoriteArr.count
            favoriteArr.insert(a, at: i)//append(a as Any)
        }
        
        Favorite.delegate?.reloadData()
        callback()
    }
}

protocol FavoriteDelegate {
    func reloadData()
}
