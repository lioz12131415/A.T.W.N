//
//  DesignableBlurEffect.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 21/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {
    
    @IBInspectable var borderW: CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = borderW
        }
    }
    
    @IBInspectable var borderC: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderC.cgColor
        }
    }
    
    @IBInspectable var borderR: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = borderR
        }
    }
    
    @IBInspectable var circle: Bool = false {
        didSet{
            if circle {
                self.layer.cornerRadius = self.frame.size.width / 2
                self.clipsToBounds = true
            }else{
                self.clipsToBounds = false
            }
        }
    }
}
