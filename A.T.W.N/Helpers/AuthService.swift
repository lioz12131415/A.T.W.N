//
//  AuthService.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 25/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class AuthService{
    //-------------------------------
    /** the class local variables **/
    //-------------------------------
    static var userKey = ""
    static let pass = "123456"
    static var signUpStatus = false
    static let unikEmail = createUnikEmail()
    static let userReference = ref.child("users")
    static let ref = Database.database().reference()
}

extension AuthService {
    static func signUp(onSuccess: @escaping () -> Void, isAlreadyAccount: @escaping() -> Void, onError: @escaping () -> Void){
        //-----------------------------------
        //MARK: sign Up user to firebase Auth
        //-----------------------------------
        Auth.auth().createUser(withEmail: unikEmail, password: pass) { (user, error) in
            if error != nil{
                if error!.localizedDescription.isAlreadyAccount() {
                    isAlreadyAccount()
                }
                onError()
                return
            }
            guard let uid = user?.user.uid else{ return }
            self.setUserInfo(email: unikEmail, uid: uid, onSuccess: { onSuccess() })
        }
    }
    
    static func signIn(onSuccess: @escaping () -> Void){
        //-----------------------------------
        //MARK: sign In user to firebase Auth
        //-----------------------------------
        Auth.auth().signIn(withEmail: unikEmail, password: pass) { (user, error) in
            if error != nil{ return }
            onSuccess()
        }
    }
    
    static func setUserInfo(email: String, uid: String, onSuccess: @escaping () -> Void){
        //----------------------------------------------
        //MARK: save the user info in firebase data base
        //----------------------------------------------
        let newUserReference = userReference.child(uid)
        newUserReference.setValue(["unikEmail": email, "isSignUp": false])
        onSuccess()
    }
    
    static func createUnikEmail() -> String {
        if userKey.isEmptyString() {
            setUid { return "\(userKey)@gmail.com" }
        }
        return "\(userKey)@gmail.com"
    }
    
    static func setUid(callback: @escaping() -> Void) {
        let key = UIDevice.current.identifierForVendor!.uuidString
        let split = key.split(separator: "-")
        
        for str in split {
            userKey.append("\(str)")
        }
        callback()
    }
    
    static func userSignUpStatus() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        userReference.child(uid).observeSingleEvent(of: .value) { (snap) in
            //.observe(.value) { (snap) in
            guard let dict = snap.value as? dictionary else { return }
            
            if let isSignUp = dict["isSignUp"] as? Bool {
                signUpStatus = isSignUp
                print(isSignUp)
            }
        }
    }
    
    static func checkIfUserSignUp(callback: @escaping(Bool) -> Void) {
        if signUpStatus {
            callback(true)
        }else{
            callback(false)
        }
    }
}

struct Config {
    //------------------
    //MARK: STORAGE PATH
    //------------------
    static var STORAGE_ROOT_REF = "gs://atwn-b5c66.appspot.com"
}
