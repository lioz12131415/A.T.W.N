//
//  FavoritePopup.swift
//  A.T.W.N
//
//  Created by lioz balki on 23/02/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

class FavoritePopupVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public static func show() {
        guard let vc = UIApplication.getPresentedViewController() else { return }
        
        let storyboard = UIStoryboard(name: "Popups", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FavoritePopupVC") as! FavoritePopupVC
        
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overCurrentContext
        
        vc.present(controller, animated: true, completion: nil)
    }
    
    public static func hide() {
        guard let vc = UIApplication.getPresentedViewController() as? FavoritePopupVC else {
            return
        }
        
        vc.dismiss(animated: true, completion: nil)
    }
}

extension FavoritePopupVC {
    // ============================= //
    // MARK: UIButton Action Section
    // ============================= //
    @IBAction func okTouch(_ sender: DesignableButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
