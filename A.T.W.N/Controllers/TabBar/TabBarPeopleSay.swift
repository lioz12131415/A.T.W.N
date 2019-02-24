//
//  TabBarPeopleSay.swift
//  A.T.W.N
//
//  Created by lioz balki on 09/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class TabBarPeopleSay: UIButton {
    
    fileprivate let index = 2
    static var delegate: TabBarPeopleSayDelegte?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        TabBarPeopleSay.delegate?.peopleSayTouch(selectedIndex: index)
    }
}

protocol TabBarPeopleSayDelegte {
    func peopleSayTouch(selectedIndex: Int)
}
