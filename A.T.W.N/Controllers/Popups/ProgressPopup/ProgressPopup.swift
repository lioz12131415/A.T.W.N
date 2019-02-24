//
//  ProgressPopup.swift
//  A.T.W.N
//
//  Created by lioz balki on 06/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class ProgressPopup: UIViewController {
    
    @IBOutlet weak var progressView: DesignableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Animation.flipAnimation(with: progressView, howManyTimes: 1000, delay: 0)
    }
    
    static func showProgressPopup(view: UIViewController){
        DispatchQueue.main.async {
            let controller = UIStoryboard.init(name: "Popups", bundle: nil).instantiateViewController(withIdentifier: "ProgressPopup") as! ProgressPopup
            
            controller.modalTransitionStyle = .crossDissolve
            controller.modalPresentationStyle = .overCurrentContext
            view.present(controller, animated: true, completion: nil)
        }
    }
    
    static func hideProgressPopup(callback:(() -> Void)? = nil) {
        Helpers.delay(time: 1) {
            let currentView = UIApplication.getPresentedViewController()
            if let p = currentView as? ProgressPopup {
                p.selfDismiss()
                p.removeFromParent()
                
                if p.progressView != nil {
                    p.progressView.removeFromSuperview()
                }
            }
            Animation.stopFlip()
            if callback != nil {  callback!() }
        }
    }
}
