//
//  Helpers.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 20/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth

class Helpers {
    //---------------------------------------------------------------
    //MARK: handel the splash screen Background
    static var lastSource = ""
    static var looper: AVPlayerLooper?
    static var playerLayer = AVPlayerLayer()
    //---------------------------------------------------------------
}

extension Helpers {
    //---------------------------------------------------------------
    //MARK: handel the splash screen Background
    //---------------------------------------------------------------
    static func setBackground(v: UIView, name: String, type: String){
        let player = AVQueuePlayer()
        
        guard let url = Bundle.main.url(forResource: name, withExtension: type) else { return }
        
        looper = AVPlayerLooper(player: player, templateItem: AVPlayerItem(asset: AVAsset(url: url)))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        playerLayer.frame = v.frame
        v.layer.addSublayer(playerLayer)
        player.play()
    }
    
    static func hideBackground(){
        looper = nil
        playerLayer.removeFromSuperlayer()
    }
}

extension Helpers {
    //---------------------------------------------------------------
    //MARK: handel if this is the first time app open after install
    //---------------------------------------------------------------
   static func appAlreadyLaunchedOnce() -> Bool{
        let defaults = UserDefaults.standard

        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}

extension Helpers {
    //----------------------------
    //MARK: random numbers section
    //----------------------------
    static func rand(upper: Int)->Int{
        return Int(arc4random_uniform(UInt32(upper)))
    }
    
    static func randWith(min: CGFloat, max: CGFloat) -> CGFloat {
        let rand = CGFloat.random(in: min..<max)
        return rand
    }
    
    //-------------------------
    //MARK: random even numbers
    //-------------------------
    static func evenRand(upper: Int,callback: @escaping(Int) -> Void){
        while true {
            let r = Int(arc4random_uniform(UInt32(upper)))
            if r % 2 == 0 {
                callback(r)
                break
            }
        }
    }
}

extension Helpers {
    //---------------------------------
    //MARK: add tap guster to imageView
    //---------------------------------
    static func addTapGusterImageView(with image: UIImageView, target: UIViewController, selector: Selector?){
        let tap = UITapGestureRecognizer(target: target, action: selector)
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tap)
    }
    
    //------------------------------
    //MARK: add tap guster to UIView
    //------------------------------
    static func addTapGusterUIView(with view: UIView, target: UIViewController, selector: Selector?){
        let tap = UITapGestureRecognizer(target: target, action: selector)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    
    //------------------------------
    //MARK: add tap guster to UIView
    //------------------------------
    static func addTapGusterUITextView(with textView: UIView, target: UITextView, selector: Selector?){
        let tap = UITapGestureRecognizer(target: target, action: selector)
        textView.isUserInteractionEnabled = true
        textView.addGestureRecognizer(tap)
    }
    
    //----------------------------------
    //MARK: add Pan Tap Guster to UIView
    //----------------------------------
    static func addPanGestureUIView(with view: UIView, target: UIViewController, selector: Selector?){
        let gesture = UIPanGestureRecognizer(target: target, action: selector)
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        gesture.delegate = target as? UIGestureRecognizerDelegate
    }
}

extension Helpers {
    //----------------------------
    //MARK: handel the image piker
    //----------------------------
    static func presentPikerController(with v: UIViewController){
        let pickerController = UIImagePickerController()
        
        if let controller = v as? UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        pickerController.delegate = controller
        v.present(pickerController, animated: true, completion: nil)
        }
    }
}

extension Helpers {
    //-----------------------
    //MARK: cast data section
    //-----------------------
    static func imageData(with image: UIImage, callback: @escaping( Data ) -> Void) {
        if let data = image.jpegData(compressionQuality: 0.1) {
            callback(data)
        }
    }
}

extension Helpers {
    //---------------------------------------------------
    //MARK: help to handle the user status in the project
    //---------------------------------------------------
    static func userCurrentStatus() -> userStatus {
        if let _ = Auth.auth().currentUser {
            return userStatus.user
        }else{
            return userStatus.newUser
        }
    }
}

extension Helpers {
   static func notificationCenter(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?) {
        
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: aName, object: anObject)
    }
}

extension Helpers {
    //------------------
    //MARK: create delay
    //------------------
    static func delay(time: Double, callback: @escaping() -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            callback()
        }
    }
}

extension Helpers {
    //--------------------------------------------
    //MARK: handel the from vc enum func thet give
    //the currect enum rowValue( string type )/...
    //--------------------------------------------
    static func fromVC(vc: fromVC) -> String {
        return vc.rawValue
    }
}

extension Helpers {
    //-----------------------------------------------
    //MARK: set & get the current source the user use
    //-----------------------------------------------
    static func setLastSource(with sourceId: String) {
        self.lastSource = sourceId
    }
    
    static func getLastSource() -> String {
        return self.lastSource
    }
}

extension Helpers {
    //--------------------------------------------------
    //MARK: static func that help us change images color
    //--------------------------------------------------
    static func changeImagesColor(_ imagesArr:[UIImageView]) {
        for img in imagesArr {
            img.setImageColor(.white)
        }
    }
}

extension Helpers {
    //-------------------------------
    //
    //-------------------------------
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    // Screen height.
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}

extension Helpers {
    static func ContryCodeArr() -> Array<String> {
        return [ "ae","ar","at","au","be","bg","br","ca","ch",
                 "cn","co","cu","cz","de","eg","fr","gb","gr",
                 "hk","hu","id","ie","il","in","it","jp","kr",
                 "lt","lv","ma","mx","my","ng","nl","no","nz",
                 "ph","pl","pt","ro","rs","ru","sa","se","sg",
                 "si","sk","th","tr","tw","ua","us","ve","za" ]
    }
}
