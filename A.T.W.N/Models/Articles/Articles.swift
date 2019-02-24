//
//  Articles.swift
//  A.T.W.N
//
//  Created by lioz balki on 02/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

struct NewsApi: Codable {
    
    var status: String?
    var totalResults: Int?
    var articles: [Articles]
}

struct NewsSources: Codable {
    var sources: [Sources]?
}

struct Articles: Codable {
    
    var url: URL?
    var sortBy: Int?
    var type: String?
    var title: String?
    var author: String?
    var source: Source?
    var category: String?
    var urlToImage: String?
    var description: String?
    var publishedAt: String?

    static var delegate: ArticlesDelegate?
}

struct Sources: Codable {
    
    var id: String?
    var name: String?
    var description: String?
    var url: URL?
    var category: String?
    var language: String?
    var country: String?

}

struct Source: Codable {
    var id: String?
    var name: String?
}


extension Articles {
    static func setArticle(dict: [String: Any]) -> Articles {
        var article = Articles()
        var source = Source()
        
        if let dict = dict["source"] as? [String : Any] {
            source = Source.setSources(dict: dict)
        }
        
        article.source = source
        article.type = "articles"
        article.url = dict["url"] as? URL
        article.title = dict["title"] as? String
        article.author = dict["author"] as? String
        article.urlToImage = dict["urlToImage"] as? String
        article.publishedAt = dict["publishedAt"] as? String
        article.description = dict["description"] as? String
        
        Articles.delegate?.reloadData()
        return article
    }
}

extension Source {
    static func setSources(dict: [String : Any ] ) -> Source {
        var s = Source()
       
        s.id = dict["id"] as? String
        s.name = dict["name"] as? String
        
        return s
    }
}

protocol ArticlesDelegate {
    func reloadData()
}
