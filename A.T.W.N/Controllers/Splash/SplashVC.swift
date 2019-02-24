//
//  ViewController.swift
//  A.T.W.N
//
//  Created by lioz balki on 01/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit
import FirebaseAuth

class SplashVC: UIViewController {

    @IBOutlet weak var circleView: DesignableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //------------------------------------------------
        //MARK: when the view did load start the animation
        Animation.growingCircleAnimation(with: circleView)
        //------------------------------------------------
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkManager.setUser()
        NetworkManager.getData()
        AuthService.userSignUpStatus()
        NotificationCenter.default.addObserver(self, selector: #selector(handel), name: .weHaveData, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //----------------------------------------------------
        //MARK: when the view did Disappear stop the animation
        Animation.stopGrowingCircleAnimation()
        //----------------------------------------------------
    }
    
    @objc func handel() {
        Helpers.delay(time: 0) {
            self.checkAppStatus()
        }
    }
    
    func checkAppStatus(){
        //-----------------------------------------
        //MARK: check the user status and handle it
        //-----------------------------------------
        if Helpers.appAlreadyLaunchedOnce(){
            //----------------------------------
            //MARK: if its not the first time we
            // haldel the situation by check if
            // the user is login or not ..
            switch Helpers.userCurrentStatus() {
                case .user: userLogin() /* case user is login */
                case .newUser: newUser() /* case user is newUser */
            }
        }else{
            //-----------------------------------
            //MARK: if this is the first time the
            // app install send the user to login
             newUser()
            //-----------------------------------
        }
    }
    
    private func userLogin(){
        Controllers.performSegue(with: self, delay: 1, Identifier: .splashToTabBar, sender: nil)
    }
    
    private func newUser(){
        AuthService.signUp(onSuccess: {
            //* case the user is already account *//
            AuthService.signIn { self.userLogin() }
        }, isAlreadyAccount: {
            //* case the user is already account *//
            AuthService.signIn { self.userLogin() }
        }) { /** case of error from fire base  **/ }
    }
}


//guard let _ = try? Auth.auth().signOut() else { return }
