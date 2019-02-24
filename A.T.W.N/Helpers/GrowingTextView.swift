//
//  GrowingTextView.swift
//  A.T.W.N
//
//  Created by lioz balki on 07/02/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

class GrowingTextView: UITextView {
    
    var growingDelegate: GrowingDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
}

extension GrowingTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        //-----------------------------------------
         let fixedWidth = textView.frame.size.width
        //-----------------------------------------
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        self.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        
        self.growingDelegate?.heightChange(height: newSize.height + 32)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text != "" else {
            self.setPlaceHolder(with: "Message")
                return
        }
    }
}

protocol GrowingDelegate {
    func heightChange(height: CGFloat)
}
