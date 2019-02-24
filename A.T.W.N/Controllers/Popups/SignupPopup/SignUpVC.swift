//
//  SignUpVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 11/01/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
    }
    
    public static func show() {
        let currentVc = UIApplication.getPresentedViewController()
        
        let storyboard = UIStoryboard(name: "Popups", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overCurrentContext
        
        currentVc?.present(controller, animated: true, completion: nil)
    }
}

extension SignUpVC {
    //-----------------------------
    //MARK: UIButton Action Section
    //-----------------------------
    @IBAction func signUpTouch(_ sender: UIButton) {
        self.dismiss(animated: true) {
           Controllers.showSignUp()
        }
    }
    
    @IBAction func closeTouch(_ sender: UIButton) {
        self.selfDismiss()
    }
}
