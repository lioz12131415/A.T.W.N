//
//  Controllers.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 20/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class Controllers {
    static func performSegue(with v: UIViewController, delay: Int, Identifier: performSegueIdentifiers, sender: Any?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            v.performSegue(withIdentifier: Identifier.rawValue, sender: sender)
        }
    }
    
    static func showSignUp(){
        if let vc = UIApplication.getPresentedViewController() {
            
            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "EmailVC") as! EmailVC
            controller.modalPresentationStyle = .overCurrentContext
            controller.modalTransitionStyle = .crossDissolve
            vc.present(controller, animated: true, completion: nil)
        }
    }
    
    static func showSourcesPopup(view: UIViewController){
        let controller = UIStoryboard.init(name: "Popups", bundle: nil).instantiateViewController(withIdentifier: "SourcesPopupVC") as! SourcesPopupVC
        
        controller.sources = allNecessarySources
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
       view.present(controller, animated: true, completion: nil)
    }
    
    static func showProgressPopup(view: UIViewController){
        let controller = UIStoryboard.init(name: "Popups", bundle: nil).instantiateViewController(withIdentifier: "ProgressPopup") as! ProgressPopup
        
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        view.present(controller, animated: true, completion: nil)
    }
}

