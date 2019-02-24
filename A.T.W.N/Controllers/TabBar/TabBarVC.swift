//
//  TabBarVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 19/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class TabBarVC: UIViewController {
    
    @IBOutlet var containerView: [UIView]!
    @IBOutlet var borderLineTabBar: [UIView]!
    @IBOutlet weak var contryCodeView: UIView!
    
    ///
    var currentIndex = 0
    
    static var mainDelegate: TabBarMainDelegate?
    static var topNewsDelegate: TabBarTopDelegate?
    static var profileDelegate: TabBarProfileDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //------------------------
        TabBarView.delegate = self
        //------------------------
    }
}

extension TabBarVC {
    //-------------------------
    //UIButton IBAction Section
    //-------------------------
    @IBAction func switchContryTouch(_ sender: Any) {
        
        switch currentIndex {
            case 0: FilterByContryPopupVC.show(self)
            case 3: TabBarVC.profileDelegate?.favoriteViewHandle()
        default:
            Animation.rotatedView(with: contryCodeView)
        }
  
    }
}

extension TabBarVC: TabBarViewDelegate {
    //-----------------------------------
    //MARK: handel the tab bar section ..
    //-----------------------------------
    func selectedIndex(selectedIndex: Int) {
        if currentIndex != selectedIndex {
            for line in borderLineTabBar {
                line.alpha = 0
            }
            //------------------------------------------------------------------
            Animation.borderLineAnimation(line: borderLineTabBar[selectedIndex])
            //------------------------------------------------------------------
        }else{
            //--------------------------------------
            handelTaps(selectedIndex: selectedIndex)
            //--------------------------------------
        }
        //----------------------------
        currentIndex = selectedIndex
        //----------------------------
        setNavTitle(by: selectedIndex)
        //----------------------------
        handelIndexs(i: selectedIndex)
    }
    
    private func setNavTitle(by i: Int){
        ///
        switch i {
            case 0: self.navigationItem.title = "A.T.W.N"
            case 1: self.navigationItem.title = "Top News"
            case 2: self.navigationItem.title = "People Say"
            case 3: self.navigationItem.title = "Profile"
        default:
            break
        }
    }
        
    private func handelIndexs(i: Int) {
        containerView.showContiner(indexToShow: i)
    }
    
    private func handelTaps(selectedIndex: Int){
        switch selectedIndex {
            case 0: TabBarVC.mainDelegate?.scrollMain()
            case 1: TabBarVC.topNewsDelegate?.scrollTopNews()
        default:
            break
        }
    }
}

protocol TabBarMainDelegate {
   func scrollMain()
}

protocol TabBarTopDelegate {
    func scrollTopNews()
}

protocol TabBarProfileDelegate {
    func favoriteViewHandle()
}
