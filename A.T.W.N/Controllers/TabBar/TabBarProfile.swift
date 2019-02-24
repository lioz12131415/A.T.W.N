//
//  TabBarProfile.swift
//  A.T.W.N
//
//  Created by lioz balki on 09/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class TabBarProfile: UIButton {
    
    fileprivate let index = 3
    static var delegate: TabBarProfileDelegte?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        TabBarProfile.delegate?.profileTouch(selectedIndex: index)
    }
}

protocol TabBarProfileDelegte {
    func profileTouch(selectedIndex: Int)
}
