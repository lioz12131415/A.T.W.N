//
//  ArticlesCategories.swift
//  A.T.W.N
//
//  Created by lioz balki on 08/02/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

struct Health: Codable {
    static var articles: [Articles]?
}

struct Sports: Codable {
    static var articles = [Articles]()
}

class General {
    static var articles = [Articles]()
}

struct Science: Codable {
    static var articles = [Articles]()
}

struct Business: Codable {
    static var articles = [Articles]()
}

struct Technology: Codable {
    static var articles = [Articles]()
}

struct Entertainment: Codable {
    static var articles: [Articles]?
}
