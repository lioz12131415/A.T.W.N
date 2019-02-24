//
//  AlertPopupVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 07/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class AlertPopupVC: ViewControllerPannable {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
    }

    static func showAlert(view: UIViewController){
        Helpers.delay(time: 1) {
            let controller = UIStoryboard.init(name: "Popups", bundle: nil).instantiateViewController(withIdentifier: "AlertPopupVC") as! AlertPopupVC
            
            controller.modalTransitionStyle = .crossDissolve
            controller.modalPresentationStyle = .overCurrentContext
            view.present(controller, animated: true, completion: nil)
        }
    }
}

extension AlertPopupVC {
    //------------------------------
    //MARK: UIButtons action section
    //------------------------------
    @IBAction func closeTouch(_ sender: Any) {
        self.selfDismiss()
    }
}
