//
//  Enums.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 20/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import Foundation

//------------------------------------------------------------
// MARK: enum for all perform Segue Identifiers in the project
enum performSegueIdentifiers: String {
    case toTabBar = "toTabBar" 
    case toSignUp = "toSignUp"
    case toNameVC = "toNameVC"
    case toArticel = "toArticel"
    case toImageVC = "toImageVC"
    case toNewPostVC = "toNewPostVC"
    case toPeopleSay = "toPeopleSay"
    case verifyToMain = "verifyToMain"
    case mainToArticel = "mainToArticel"
    case splashToLogin = "splashToLogin"
    case phoneToVerify = "phoneToVerify"
    case passwordToMain = "passwordToMain"
    case splashToTabBar = "splashToTabBar"
    case emailToPassword = "emailToPassword"
    case mainToCategories = "mainToCategories"
    case topNewsToArticle = "topNewsToArticle"
    case toSelectedCategory = "toSelectedCategory"
    case toPeopleSayArticleVC = "toPeopleSayArticleVC"
    case SelectedCategoryToArticle = "SelectedCategoryToArticle"
}
//------------------------------------------------------------

//--------------------------------------------
//MARK: fromVC save from witch vc we come from
//we handel this with user defult..
enum fromVC: String {
     case LoginVC = "LoginVC"
     case SignInWithEmailVC = "SignInWithEmailVC"
     case SignUpWithEmailVC = "SignUpWithEmailVC"
}
//--------------------------------------------

//--------------------------------------------
//MARK: userStatus help to see the user status
enum userStatus: String {
    case newUser
    case user
}
//--------------------------------------------

//--------------------------------------------
//MARK: userStatus help to see the user status
enum phoneStatus{
    case haveCountryCode
    case dontCountryCode
    case invalidNumber
}
//--------------------------------------------

//-----------------------------------
//MARK: all articles categories types
public enum categories: String {
    case sports
    case health
    case science
    case business
    case technology
    case entertainment
    case general
    
    var str: String {
        switch self {
        case .general: return "general"
        case .sports: return "sports"
        case .health: return "health"
        case .science: return "science"
        case .business: return "business"
        case .technology: return "technology"
        case .entertainment: return "entertainment"
        }
    }
        
    static func categoriesArr() -> [categories] {
        let arr: [categories]  =
            [ categories.sports, categories.health,
              categories.science, categories.business,
              categories.general, categories.technology, categories.entertainment ]
        return arr
    }
}
//-----------------------------------

//-------------------
///
enum TimerCall {
    case invalidate
    case fire
}
//-------------------

//-------------------
///
enum AnimatedStatus {
    case start
    case stop
}
//-------------------

//-------------------
enum AnimatedExecute {
    case execute
    case unExecuted
}
//-------------------

//-------------------
enum TopNewsStatus {
    case selected
    case unSelected
}
//-----------------------

//-----------------------
enum KeyboardStatus{
    
    case open
    case close
    case update
    
}
//-----------------------

//-----------------------
enum KeyboardUpdateStatus{
    
    case plus
    case minus
    case equal
    
}
//-----------------------
