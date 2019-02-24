//
//  ArticelVCExtension.swift
//  A.T.W.N
//
//  Created by lioz balki on 08/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

var execute = true
typealias state = UIGestureRecognizer.State


extension ArticelVC : UIGestureRecognizerDelegate{
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        let h = self.view.frame.height
        
        if gestureRecognizer.state == state.began || gestureRecognizer.state == state.changed {
            
            let velocity = gestureRecognizer.velocity(in: self.view)
            
            if velocity.y > 0{
                ProgressPopup.hideProgressPopup()
                UIView.animate(withDuration: 0.5) {
                    self.topView.center.y = (h + h / 2)
                }
            
            }else{
                openWebView()
                UIView.animate(withDuration: 0.5) {
                    self.topView.center.y = self.view.center.y + 40
                }
            }
            
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
    }
    
    func openWebView(){
        
        Animation.hideArrowAimation()
        ProgressPopup.showProgressPopup(view: self)
        
        let w = webViewContainer.frame.width
        let h = webViewContainer.frame.height
        
        if let urlStr = articel?.url {
            let request = URLRequest(url: urlStr)
            webView.frame = CGRect(x: 0, y: 0, width: w, height: h)
            
            webView.load(request)
            webViewContainer.addSubview(webView)
        }
    }
}
