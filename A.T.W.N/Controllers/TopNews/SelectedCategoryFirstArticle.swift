//
//  SelectedCategoryFirstArticle.swift
//  A.T.W.N
//
//  Created by lioz balki on 20/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class SelectedCategoryFirstArticle: ViewControllerPannable {

    override func viewDidLoad() {
        super.viewDidLoad()
        ///
    }
    
    static func show(){
        //----------------------------------------------------------
        let currentView = UIApplication.getPresentedViewController()
        //----------------------------------------------------------
        let controller = UIStoryboard.init(name: "TopNews", bundle: nil).instantiateViewController(withIdentifier: "SelectedCategoryFirstArticle") as! SelectedCategoryFirstArticle
        //----------------------------------------------------------
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overCurrentContext
        currentView?.present(controller, animated: true, completion: nil)
        //----------------------------------------------------------
    }
}
