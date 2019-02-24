//
//  BounceButtonAnimation.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 23/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class BounceButtonAnimation: UIButton {
    //--------------------------------------------------------------------------------
    // MARK: in the ( IBDesignable folder -> DesignableButton )
    // we give DesignableButton object type -> BounceButtonAnimation for the animation
    // DesignableButton can be impoloment object type of BounceButtonAnimation
    // because BounceButtonAnimation is type UIButton..
    //--------------------------------------------------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
        super.touchesBegan(touches, with: event)
    }
}
