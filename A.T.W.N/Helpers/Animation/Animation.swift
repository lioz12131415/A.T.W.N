//
//  Animation.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 20/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit
import ViewAnimator

class Animation {
   //------------------------------------------------------
   //MARK: The timer use for all the animation thet need em
   //Dont Forget all the classes is static andf we need to
   //handel the timer and stop en after the animation stop
    static var timer = Timer()
    static let screenHeight = UIScreen.main.bounds.height
   //------------------------------------------------------
}

extension Animation{
    //----------------------------------
    //MARK: Handel Up And Down Animation
    //----------------------------------
    static var view: UIView?
    static var max: CGFloat?
    static var min: CGFloat?
    static var mult = 1
    
    static func startUpAndDown(with view: UIView){
        self.view = view
        upAndDown(with: view)
    }
    
    static func upAndDown(with view: UIView){
        self.min = view.center.y
        self.max = view.center.y + 5

        timer = Timer.scheduledTimer(timeInterval: 0.055, target: self, selector: (#selector(movement)), userInfo: view, repeats: true)
    }
    
    @objc static func movement() {
        guard let min = self.min,
            let max = self.max,
                let v = self.view else { return }
        
        self.view?.center.y +=  0.5 * CGFloat( mult )
            
        if Int(v.center.y) > Int(max){
            mult = -1
        }else if Int(v.center.y) < Int(min) {
            mult = 1
        }
    }
    
   static func stopUpAndDown(){
        timer.invalidate()
        self.max = nil
        self.min = nil
        self.view = nil
        self.mult = 1
    }
}

extension Animation{
    //----------------------------------------------------------
    //MARK: flip UIView amimation will spaning the view to Right
    //----------------------------------------------------------
    static var delay = 0
    static var flipView: UIView?
    static var howManyTimes = 0
    static var count = 0
    
    static func flipAnimation(with v: UIView, howManyTimes: Int, delay: Int){
    
    self.flipView = v
    self.delay = delay
    self.howManyTimes = ( howManyTimes - 1 )
    
    flipViewAnimation()
    
    }
    
    private static func flipViewAnimation(){
        let transitionOptions: UIView.AnimationOptions = [ .transitionFlipFromRight ]
        
        if let v = self.flipView {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds( delay ) ) {
            UIView.transition(with: v, duration: 1.0, options: transitionOptions, animations: {
                }, completion: { (finish) in
                    
                if self.count < howManyTimes { flipViewAnimation() } else { stopFlip() }
                count += 1
                })
            }
        }
    }
    
     static func stopFlip(){
        howManyTimes = 0
        flipView = nil
        delay = 0
    }
}

extension Animation {
    //----------------------------------------
    //MAEK: growing view with animaion section
    //----------------------------------------
    static var circleView: UIView?
    
    static func growingCircleAnimation(with circleView: UIView){
        //--------------------------------------------------
        //MAEK: handle the animation with UIView.animate()
        //import to remember dismiss the animation after use
        //--------------------------------------------------
        self.circleView = circleView
            circleView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(startBreatheViewAnimation)), userInfo: nil, repeats: true)
     
    }
    
    @objc private static func startBreatheViewAnimation(){
        
        if let circleView = circleView {
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                circleView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                
            }) { (finished) -> Void in
                UIView.animate(withDuration: 0.4, animations: { () -> Void in
                    circleView.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
    static func stopGrowingCircleAnimation(){
        timer.invalidate()
        self.circleView = nil
    }
}

extension Animation {
    //-----------------------------------------
    //MAEK: arrow animated hidden one after one
    //-----------------------------------------
    static var row = 0
    static var imagesArr: [UIImageView]?
    
    static func startArrowAimation(with imagesArr: [UIImageView]) {
        //-------------------------------------
        //MAEK: start point of this Animation
        //remmber to hide the animation because
        //this cass is static class -> :) .
        //-------------------------------------
        self.imagesArr = imagesArr
        timer = Timer.scheduledTimer(timeInterval: 0.45, target: self, selector: (#selector(arrowAnimated)), userInfo: view, repeats: true)
    }
    
    static func hideArrowAimation(){
        row = 0
        timer.invalidate()
        
        if let imagesArr = imagesArr {
        for img in imagesArr { img.alpha = 0 }
        }
    }
    
    @objc private static func arrowAnimated(){
        if let imagesArr = imagesArr{
            if row == imagesArr.count { row = 0 }
            
            UIView.animate(withDuration: 0.4) {
                if imagesArr[row].alpha == 0 {
                    imagesArr[row].alpha = 0.7
                }else{
                    imagesArr[row].alpha = 0
                }
                row += 1
            }
        }
    }
}

extension Animation {
    //--------------------------------------------
    //MAEK: tableView animated apper one after one
    //--------------------------------------------
    static func rowOneAfterOne(with tableView: UITableView, direction: Direction){
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let fromAnimation = AnimationType.from(direction: direction, offset: 500.0)
            UIView.animate(views: tableView.visibleCells, animations: [fromAnimation], duration: 0.5)
        }
    }
}

extension Animation {
    //----------------------------------
    //MAEK: tab bar border line animated
    //----------------------------------
    static var currntWeight: CGFloat?
    static func borderLineAnimation(line: UIView){
        
        currntWeight = line.frame.width
        line.frame.size.width = 0
        
        UIView.animate(withDuration: 0.7) {
            line.alpha = 1
            if let weight = currntWeight {
            line.frame.size.width += weight
            }
        }
    }
}

extension Animation {
    //------------------------------------------
    //MAEK: view go up from bottom of the screen
    //------------------------------------------
    static var centerScreen: CGFloat?
    static var fromButtomView: UIView?
    static var viewPositionAfter: CGFloat?
    //---------------------------------------
    //MARK: the enum section of this animated
    static var timerCall = TimerCall.fire
    static var fromBottomStatus = AnimatedStatus.start
    //---------------------------------------
    
    static func viewFromButtomAnimated(with view: UIView){
        //-------------------------------------------------------
        //MARK: start the animation by find the current positions
        //to put the view after that stert the timer and += to
        //is center y point ...
        //-------------------------------------------------------
        let centerScreen = screenHeight / 2
        view.center.y = ( screenHeight + centerScreen )
        
        self.fromButtomView = view
        self.centerScreen = centerScreen
        
        if timerCall == .fire {
        timer = Timer.scheduledTimer(timeInterval: 0.055, target: self, selector: (#selector(fromButtomToTop)), userInfo: view, repeats: true)
            timerCall = .invalidate
        }
    }
    
    @objc private static func fromButtomToTop() {
        //-----------------------------------------------------------
        //MARK: timer method start the functionality of the animation
        //-----------------------------------------------------------
        if let fromButtomView = fromButtomView {
            
            let stopPostion = screenHeight - 120
            
            if fromButtomView.frame.maxY >= stopPostion {
                UIView.animate(withDuration: 0.2) {
                    fromButtomView.center.y -= 20.0
                }
            }else{
                stopTimer()
                viewPositionAfter = fromButtomView.center.y
            }
        }
    }
    
    private static func stopTimer(){
        timer.invalidate()
        fromBottomStatus = .stop
    }
    
    static func stopFromButtomAnimated(){
        timerCall = .fire
        centerScreen = nil
        fromButtomView = nil
        viewPositionAfter = nil
        fromBottomStatus = .start
    }
}

extension Animation {
    //----------------------------
    ///
    //----------------------------
    static func rotatedView(with view: UIView){
        UIView.animate(withDuration: 2.0, animations: {
            for _ in 1...2 {
                view.transform = view.transform.rotated(by: CGFloat.pi )
            }
        })
    }
}

extension Animation {
    static func changeViewHeight(_ const: NSLayoutConstraint, _ height: CGFloat) {
        guard const.constant == (height/2) else {
            UIView.animate(withDuration: 1) { const.constant += (height/2) }
                return
        }
         UIView.animate(withDuration: 1) { const.constant -= (height/2) }
    }
}
