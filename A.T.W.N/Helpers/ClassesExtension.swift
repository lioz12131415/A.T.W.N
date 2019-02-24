//
//  ClassesExtension.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 24/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit


typealias calendar = Set<Calendar.Component>

extension String {
    //------------------------------
    //MARK: extension String section
    //------------------------------
    func isValidPhone(callback: @escaping( phoneStatus ) -> Void){
        //------------------------------
        //MARK: check if phone number is
        // Ten digits ..
        //------------------------------
        var count = 0
        
        for char in self {
            if count == 0 {
                if char == "+" {
                    callback( .haveCountryCode )
                    break
                }
            }
            count += 1
        }
        
        if count == 10 {
            callback( .dontCountryCode )
        }else{
            callback( .invalidNumber )
        }
    }
    
    func isValidEmail() -> Bool {
        print("validate emilId: \(self)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = email.evaluate(with: self)
        print(result)
        return result
    }
    
    func isAlreadyAccount() -> Bool{
        let alreadyAccountError = "The email address is already in use by another account."
        
        if self == alreadyAccountError {
            return true
        }else{
            return false
        }
    }
    
    func isEmptyString() -> Bool {
        if self == "" {
            return true
        }else{
            return false
        }
    }
    
    var dateFromTimestamp: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = dateFormatter.date(from: self)
        return date
    }
}

//----------------------------------------
//MARK: extension UIViewController section
//----------------------------------------
extension UIViewController {
    //-----------------------------------------------
    //MARK: make a global func that hide the keyboard
    //-----------------------------------------------
    func hideKeyboardWhenTouchAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func dissmisViewWhenTouch(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }
    
   @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func selfDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

///
extension UILabel {
    var numberOfVisibleLines: Int {
        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
}

///
extension UIApplication{
    class func getPresentedViewController() -> UIViewController? {
        var presentViewController = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentViewController?.presentedViewController {
            presentViewController = pVC
        }
        return presentViewController
    }
}

extension Array {
    ///
    func showContiner(indexToShow: Int){
        
        if let arr = self as? [UIView] {
            
            for i in 0...arr.count - 1 {
                if i == indexToShow {
                    arr[i].isHidden = false
                }else{
                    arr[i].isHidden = true
                }
            }
        }
    }
}

extension UIImageView {
    func setImageColor(_ color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension Int {
    func equalZero() -> Bool {
        if self == 0 {
            return true
        }else{
            return false
        }
    }
}

extension Date {
    
    func getElapsedInterval() -> String {
        
        let calendar: calendar = [.year, .month, .weekOfYear, .day, .hour, .minute, .second]
        
        let interval = Calendar.current.dateComponents(calendar, from: self, to: Date())
        
        if let years = interval.year, years > 0 {
            return  "\(years)y"
        }
        
        if let months = interval.month, months > 0 {
            return "\(months)mo"
        }
        
        if let weeks = interval.weekOfYear, weeks > 0 {
            return "\(weeks)w"
        }
        
        if let days = interval.day, days > 0 {
            return "\(days)d"
        }
        
        if let hours = interval.hour, hours > 0 {
            return "\(hours)h"
        }
        
        if let minutes = interval.minute, minutes > 0 {
            return "\(minutes)m"
        }
        
        if let seconds = interval.second, seconds > 30 {
            return "\(seconds)s"
        }
        
        return "Just now"
    }
}

extension UITextView {
    ///
    open override func awakeFromNib() {
        super.awakeFromNib()
        Helpers.addTapGusterUITextView(with: self, target: self, selector: #selector(handleTaps))
    }
    
    func setPlaceHolder(with txt: String) {
        self.textColor = .lightGray
        self.text = txt
    }
    
    @objc func handleTaps(){
        //-------------------------
        self.becomeFirstResponder()
        //-------------------------
        if self.textColor == .lightGray {
            self.text = ""
            self.textColor = .black
        }
    }
}

extension UIImage {
    func heightInPixels() -> CGFloat {
        let heightInPoints = self.size.height
        let heightInPixels = heightInPoints * self.scale
        return heightInPixels
    }
    
    func height() -> CGFloat {
        let heightInPoints = self.size.height
        return heightInPoints
    }
}

extension UITextView {
    func textHeight() -> CGFloat {
        let sizeThatFitsTextView = self.sizeThatFits(CGSize(width: self.frame.size.width, height: CGFloat(MAXFLOAT)))
        let heightOfText = sizeThatFitsTextView.height
            return heightOfText
    }
}

extension UIScrollView {
    func scrollToBottom() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let bounds = self.bounds.size.height
            let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - bounds)
            self.setContentOffset(bottomOffset, animated: true)
        }
    }
    
    func scrollTop() {
         DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.contentOffset = CGPoint(x: 0, y: 0);
        }
    }
}

public extension NSLayoutConstraint {
    
    func changeMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint? {
        guard let item = firstItem else {
            return nil
        }
        
        let newConstraint = NSLayoutConstraint(
            item: item,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        newConstraint.priority = priority
        
        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([newConstraint])
        
        
        return newConstraint
    }
}
