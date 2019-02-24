//
//  TabBarTopNews.swift
//  A.T.W.N
//
//  Created by lioz balki on 09/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class TabBarTopNews: UIButton {
    
    fileprivate let index = 1
    static var delegate: TabBarTopNewsDelegte?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        TabBarTopNews.delegate?.topNewsTouch(selectedIndex: index)
    }
}

protocol TabBarTopNewsDelegte {
    func topNewsTouch(selectedIndex: Int)
}
