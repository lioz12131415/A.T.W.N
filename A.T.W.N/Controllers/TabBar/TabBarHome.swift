//
//  TabBarVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 09/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class TabBarHome: UIButton {
    
    fileprivate let index = 0
    static var delegate: TabBarHomeDelegte?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        TabBarHome.delegate?.homeTouch(selectedIndex: index)
    }
}

protocol TabBarHomeDelegte {
    func homeTouch(selectedIndex: Int)
}
