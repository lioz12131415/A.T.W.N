//
//  ViewInKeyboardPosion.swift
//  A.T.W.N
//
//  Created by lioz balki on 07/02/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

class ViewInKeyboardPosion: UIView {

    var status = KeyboardStatus.close

    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:
            UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

    }
    
        @objc func keyboardWillChange(notification: NSNotification) {
            guard let keyboardSize = notification.keyboardFrameBegin() ,
                let offset = notification.keyboardFrameEnd() else { return }
            self.superview?.superview?.frame.origin.y += keyboardSize.height - offset.height
            
        }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = notification.keyboardFrameBegin() else { return }
        if self.superview?.superview?.frame.origin.y == 0 || status == .close {
            self.superview?.superview?.frame.origin.y -= keyboardSize.height
                status = .open
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        guard let keyboardSize = notification.keyboardFrameBegin() else { return }
        if self.superview?.superview?.frame.origin.y != 0 {
            self.superview?.superview?.frame.origin.y += keyboardSize.height
                status = .close
        }
    }
}

extension NSNotification {
    func keyboardFrameBegin() -> CGRect? {
        if let rect = (self.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            return rect
        }
        return nil
    }

    func keyboardFrameEnd() -> CGRect? {
        if let rect = (self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            return rect
        }
        return nil
    }
}




////
////  ViewInKeyboardPosion.swift
////  A.T.W.N
////
////  Created by lioz balki on 07/02/2019.
////  Copyright © 2019 lioz balki. All rights reserved.
////
//
//import UIKit
//
//class ViewInKeyboardPosion: UIView {
//
//    var keyboardDelegate: KeyboardPosionDelegate?
//
//    var lastKeyboardH: CGFloat = 0.0
//    var status = KeyboardStatus.close
//    var update = KeyboardStatus.close
//
//
//    override func awakeFromNib() {
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:
//            UIResponder.keyboardWillShowNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//
//    }
//
//    @objc func keyboardWillChange(notification: NSNotification) {
//
//        if let keyboardSize = notification.keyboardFrameEnd() {
//
//            let keyboardHeight = keyboardSize.height
//
//            if status == .open {
//                self.frame.origin.y = keyboardHeight
//                keyboardDelegate?.updateHeight(height: keyboardHeight, status: .equal)
//                update = .update
//                lastKeyboardH = keyboardHeight
//            }
//        }
//    }
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = notification.keyboardFrameBegin() {
//
//            if self.frame.origin.y >= 0 || status == .close {
//                self.keyboardDelegate?.updateHeight(height: 0, status: .equal)
//                UIView.animate(withDuration: 0.1) {
//
//                    if self.update != .update {
//                        self.frame.origin.y -= keyboardSize.height
//                        self.keyboardDelegate?.updateHeight(height: keyboardSize.height, status: .plus)
//                    }
//                }
//
//                if self.update == .update {
//                    self.frame.origin.y -= self.lastKeyboardH
//                    self.keyboardDelegate?.updateHeight(height: self.lastKeyboardH, status: .plus)
//                }
//                self.status = .open
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = notification.keyboardFrameBegin() {
//            if self.frame.origin.y != 0 {
//
//                if status == .open {
//                    UIView.animate(withDuration: 0.1) {
//                        self.frame.origin.y += keyboardSize.height
//                        self.keyboardDelegate?.updateHeight(height: keyboardSize.height, status: .minus)
//                        self.status = .close
//                    }
//                }
//            }
//        }
//    }
//}
//
//extension NSNotification {
//    func keyboardFrameBegin() -> CGRect? {
//        if let rect = (self.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            return rect
//        }
//        return nil
//    }
//
//    func keyboardFrameEnd() -> CGRect? {
//        if let rect = (self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            return rect
//        }
//        return nil
//    }
//}
//
//protocol KeyboardPosionDelegate {
//    func updateHeight(height: CGFloat, status keyboardUpdateStatus: KeyboardUpdateStatus)
//}

//
//extension PeopleSayArticleVC: KeyboardPosionDelegate {
//    func updateHeight(height: CGFloat, status keyboardUpdateStatus: KeyboardUpdateStatus) {
//        switch keyboardUpdateStatus {
//        case .equal: gowingViewBottomConst.constant = height
//        case .plus:  gowingViewBottomConst.constant += height
//        case .minus: gowingViewBottomConst.constant -= height
//        }
//    }
//}
