//
//  TabBarVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 09/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class TabBarView: UIView {
    
   static var delegate: TabBarViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //-----------------------------
        TabBarHome.delegate = self
        //-----------------------------
        TabBarTopNews.delegate = self
        //-----------------------------
        TabBarProfile.delegate = self
        //-----------------------------
        TabBarPeopleSay.delegate = self
        //-----------------------------
    }
}

extension TabBarView: TabBarHomeDelegte{
    func homeTouch(selectedIndex: Int) {
        TabBarView.delegate?.selectedIndex(selectedIndex: selectedIndex)
            print("home", selectedIndex)
    }
}

extension TabBarView: TabBarTopNewsDelegte{
    func topNewsTouch(selectedIndex: Int) {
        TabBarView.delegate?.selectedIndex(selectedIndex: selectedIndex)
                print("topNews", selectedIndex)
    }
}

extension TabBarView: TabBarProfileDelegte{
    func profileTouch(selectedIndex: Int) {
        
        AuthService.checkIfUserSignUp { (bool) in
            guard bool else { SignUpVC.show() ; return }
                TabBarView.delegate?.selectedIndex(selectedIndex: selectedIndex)
                    print("peopleSay", selectedIndex)
        }
    }
}

extension TabBarView: TabBarPeopleSayDelegte{
    func peopleSayTouch(selectedIndex: Int) {
        TabBarView.delegate?.selectedIndex(selectedIndex: selectedIndex)
            print("peopleSay", selectedIndex)
    }
}

protocol TabBarViewDelegate {
    func selectedIndex(selectedIndex: Int)
}
