//
//  ButtonBorder.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 21/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

@IBDesignable class DesignableButton: BounceButtonAnimation {
    
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
}
