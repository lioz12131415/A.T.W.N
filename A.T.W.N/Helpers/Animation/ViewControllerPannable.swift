//
//  ViewControllerPannable.swift
//  A.T.W.N
//
//  Created by lioz balki on 07/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class ViewControllerPannable: UIViewController {
    
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer!)
    }
    
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        
        if panGesture.state == .began {
            
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            
            view.frame.origin = CGPoint(
                x: translation.x,
                y: translation.y
            )
            
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y <= 0 {
                
                UIView.animate(withDuration: 0.2
                    , animations: {
                        self.view.frame.origin = CGPoint(
                            x: self.view.center.x,
                            y: -self.view.frame.size.height
                        )
                        
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPosition!
                })
            }
        }
    }
}
