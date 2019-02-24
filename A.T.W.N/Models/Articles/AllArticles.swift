//
//  AllArticles.swift
//  A.T.W.N
//
//  Created by lioz balki on 02/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class AllArticles: Codable {
    static var sources: [Sources]?
    static var articles = [Articles]()
    static var topNews = [[Articles]]()
    static var delegete: AllArticlesDelegate?
}

extension AllArticles{
    static func setArticle(with articlesArr: [Articles], category: String){
        
        articles.removeAll()
        
        for a in articlesArr {
            var ar = a
            ar.type = "articles"
            ar.category = category
            articles.append(ar)
        }
        
        Animation.stopFlip()
        print( articles.count )
        delegete?.reloadTableData()
        NotificationCenter.default.post(name: .weHaveData, object: nil)
    }
}

protocol AllArticlesDelegate {
    func reloadTableData()
    func noDataToDisplay()
}
