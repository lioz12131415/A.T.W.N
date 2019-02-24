//
//  NetworkManager.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 30/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class NetworkManager {
    //----------------------------------------------
    //MARK: all NetworkManager necessaryn properties
    typealias dictionary = Dictionary< String , Any >
    static var delegate: NetworkManagerDelegate?
    static let baseUrl = "https://newsapi.org"
    static let apiKey = "b0d7195ef86b49608813307190cf731a"
    static let session = URLSession.shared
    static let uid = Auth.auth().currentUser?.uid
    static let ref = Database.database().reference()
    static let storegeRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF)
   //-----------------------------------------------
}

extension NetworkManager {
    //--------------------------
    //MARK: GET API DATA SECRION
    //--------------------------
    static var oneTime = true
    static func getArticles(source: String, callBack: @escaping( NewsApi ) -> Void){
        //----------------------------------------
        //MARK: get All Articles Data from the API
        //----------------------------------------
        let urlStr = "\(baseUrl)/v2/everything?pageSize=100&sources=\(source)&apiKey=\(apiKey)"
        guard let url = URL(string: urlStr ) else { return }
        session.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {
                if oneTime {
                    oneTime = false
                    Helpers.delay(time: 0, callback: { getData() })
                }
                return
            }
                let decoder = JSONDecoder()
            
            guard let result = try? decoder.decode( NewsApi.self, from: data ) else {
               delegate?.requestFailed()
                return
            }
            
            DispatchQueue.main.async {
                callBack(result)
            }
        }.resume()
    }
    
    static func getSource(country: String, callBack: @escaping( NewsSources ) -> Void){
        //----------------------------------------
        //MARK: get All Articles Data from the API
        //----------------------------------------
        let urlStr = "\(baseUrl)/v2/sources?category&language&country=\(country)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlStr ) else { return }
        session.dataTask(with: url) { (data, res, err) in
            guard let data = data else {
                //Helpers.delay(time: 2, callback: { getData() })
                return
            }
            let decoder = JSONDecoder()
            
            guard let result = try? decoder.decode( NewsSources.self, from: data ) else { return }
            
            DispatchQueue.main.async {
                callBack(result)
            }
        }.resume()
    }
    
    static func getData() {
        //------------------------------------------------------------------
        NetworkManager.getSource(country: "") { (s) in AllArticles.sources = s.sources }
        //------------------------------------------------------------------
        Helpers.setLastSource(with: "bbc-news")
        NetworkManager.setArticles(categoty: .general, sourceId: "bbc-news")
        //------------------------------------------------------------------
        NetworkManager.setBusiness(categoty: .business, sourceId: "cnbc")
        NetworkManager.setGeneral(categoty: .general, sourceId: "bbc-news")
        NetworkManager.setTechnology(categoty: .technology, sourceId: "wired")
        NetworkManager.setSports(categoty: .sports, sourceId: "bleacher-report")
        NetworkManager.setScience(categoty: .science, sourceId: "national-geographic")
    }
    
    static func setArticles(categoty: categories, sourceId: String) {
        getArticles(source: sourceId, callBack: { (articles) in
            AllArticles.setArticle(with: articles.articles, category: categoty.rawValue)
        })
    }
    
    static func setSports(categoty: categories, sourceId: String) {
        getArticles(source: sourceId, callBack: { (articles) in
            Sports.articles = articles.articles
            
            for i in 0...Sports.articles.count - 1 {
                Sports.articles[i].type = "articles"
            }
        })
    }
    
    static func setGeneral(categoty: categories, sourceId: String) {
        getArticles(source: sourceId, callBack: { (articles) in
            General.articles = articles.articles
            
            for i in 0...General.articles.count - 1 {
                General.articles[i].type = "articles"
            }
        })
    }
    
    static func setScience(categoty: categories, sourceId: String) {
        getArticles(source: sourceId, callBack: { (articles) in
            Science.articles = articles.articles
            
            for i in 0...Science.articles.count - 1 {
                Science.articles[i].type = "articles"
            }
        })
    }
    
    static func setBusiness(categoty: categories, sourceId: String) {
        getArticles(source: sourceId, callBack: { (articles) in
            Business.articles = articles.articles
            
            for i in 0...Business.articles.count - 1 {
                Business.articles[i].type = "articles"
            }
        })
    }
    
    static func setTechnology(categoty: categories, sourceId: String) {
        getArticles(source: sourceId, callBack: { (articles) in
            Technology.articles = articles.articles
            
            for i in 0...Technology.articles.count - 1 {
                Technology.articles[i].type = "articles"
            }
        })
    }
    
    static func getSourceNewsLogoUrl(source: String) -> String {
        let sourceLogoUrl = "https://res.cloudinary.com/newsapi-logos/image/upload/v1492104667/\(source).png"
        return sourceLogoUrl
    }
}

extension NetworkManager {
    static func setUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
            let path = ref.child("users").child(uid)
        
        path.observeSingleEvent(of: .value) { (snap) in
            if let dict = snap.value as? dictionary {
                User.setUser(with: dict)
            }
        }
    }
}

extension NetworkManager {
    static func signUpUser(with data: Data, _ name:String, _ email:String, callback: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let path = storegeRef.child("profile_image").child(uid)
        
        path.putData(data, metadata: nil) { (data, err) in
            guard err == nil else { return }
            
            path.downloadURL(completion: { (url, err) in
               
                if let urlStr = url?.absoluteString {
                    let userPath = ref.child("users").child(uid)
                    
                    userPath.updateChildValues(["isSignUp": true])
                    userPath.updateChildValues(["currentEmail": email, "profileImage": urlStr, "name": name])
                    
                    User.user.name = name
                    User.user.currentEmail = email
                    User.user.profileImage = urlStr
                    
                    callback()
                }
            })
        }
    }
}


extension NetworkManager {
    static func post(data aData: Data?, name aName: String, postDiscrip aPostDiscrip: String, ctegory aCategory: String, profileImage: String, callback: @escaping() -> Void){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let photoIdString = NSUUID().uuidString
        
        if let data = aData {
            let path = storegeRef.child("postImage").child(photoIdString)
            
            path.putData(data, metadata: nil) { (data, err) in
                path.downloadURL(completion: { (url, err) in
                    
                    guard let url = url?.absoluteURL else { return }
                        setPostDataBase(postImage: url, name: aName, postDiscrip: aPostDiscrip, ctegory: aCategory, profileImage: profileImage, uid: uid) {
                                callback()
                    }
                })
            }
        
        } else {
            setPostDataBase(postImage: nil, name: aName, postDiscrip: aPostDiscrip, ctegory: aCategory, profileImage: profileImage, uid: uid) {
                    callback()
            }
        }
    }
    
    static func setPostDataBase(postImage aPostImage: URL?, name aName: String, postDiscrip aPostDiscrip: String, ctegory aCategory: String, profileImage aProfileImage: String, uid: String, callback: @escaping() -> Void) {
        
        let date = Date()
        let timeInterval = date.timeIntervalSince1970
        
        let title = aPostDiscrip.suffix(4)
        
        var dict: dictionary = [
            "author": aName, "description": aPostDiscrip, "category": aCategory,
            "profileImage": aProfileImage, "timeInterval": timeInterval, "title": title  ]
        

        if let postImage = aPostImage {
            dict.updateValue("\(postImage)", forKey: "urlToImage")
        }
        
            guard let unikKey = ref.childByAutoId().key else { return }
        
            dict.updateValue("\(unikKey)", forKey: "id")
        
            let peopleSayPath = ref.child("peopleSay").child("posts").child(unikKey)
            let userPath = ref.child("users").child(uid).child("posts").child(unikKey)
        
            userPath.updateChildValues(dict)
            peopleSayPath.updateChildValues(dict)
        
            callback()
    }
}

extension NetworkManager {
    static func getPeopleSay(callback: @escaping(PeopleSayArticles) -> Void) {
        //----------------------------------------------
        let path = ref.child("peopleSay").child("posts")
        //----------------------------------------------
        path.observe(.childAdded) { (snapshot) in
            guard let dict = snapshot.value as? dictionary else { return }
            
            let peopleSay = PeopleSayArticles.setArticles(with: dict)
                callback( peopleSay )
        }
    }
}

extension NetworkManager {
    static func getMyArticles(callback: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
            let path = ref.child("users").child(uid).child("posts")
        
        path.observe(.childAdded) { (snapshot) in
            guard let dict = snapshot.value as? dictionary else { return }
                MyArticles.setMyArticles(with: dict)
            callback()
        }
    }
}

extension NetworkManager {
    static func
        postComment(with articles: PeopleSayArticles, senderName: String, text: String, senderImage: String) {
        
        guard let unikId = ref.childByAutoId().key,
           let postId = articles.id else { return }
        
        let timeInterval = Date().timeIntervalSince1970
        
        let dict: dictionary = [
            "id":unikId, "text":text, "postId":postId,
            "senderName":senderName, "senderImage":senderImage, "timeInterval":timeInterval
        ]
        
        let path = ref.child("peopleSay").child("posts")
            .child(postId).child("comments").child(unikId)
        
        path.updateChildValues(dict)
    }
    
    static func getComments(with postId: String, callback: @escaping(Comment, Int) -> Void) {
        let path = ref.child("peopleSay").child("posts").child(postId).child("comments")
        
        var count = 0
        
        path.observeSingleEvent(of: .value) { snapshot in
            print(snapshot.childrenCount) // I got the expected number of items
            let enumerator = snapshot.children
            while let _ = enumerator.nextObject() as? DataSnapshot {
                count += 1
            }
        }
        
        path.observe(.childAdded) { (snapshot) in

            guard let dict = snapshot.value as? dictionary else { return }
            let newComment = Comment.setComment(with: dict)
            
            DispatchQueue.main.async {
                callback( newComment, count )
            }
        }
    }
}

extension NetworkManager {
    static func setFavorite(article: Any, type: String) {
        
        guard let unikKey = ref.childByAutoId().key,
            let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPath = ref.child("users").child(uid).child("favorite").child(unikKey)
        
        var dict: dictionary = [:]
        let count = Favorite.favoriteArr.count
        
        if type == "peopleSayArticles" {
            
            let peopleSayArticles = article as! PeopleSayArticles
            
            dict = [
                "id": peopleSayArticles.id ?? "",
                "type": peopleSayArticles.type,
                "author": peopleSayArticles.author ?? "",
                "description": peopleSayArticles.description ?? "",
                "category": "",
                "urlToImage": peopleSayArticles.urlToImage ?? "",
                "profileImage": peopleSayArticles.profileImage ?? "",
                "timeInterval": peopleSayArticles.timeInterval ?? 0.0,
                "title": peopleSayArticles.title ?? "",
                "sortBy": count ]
            
        } else {
            
            let a = article as! Articles
            
            dict = [
                "type": a.type ?? "",
                "url": "\(a.url?.absoluteString ?? "")",
                "title": a.title ?? "",
                "author": a.author ?? "",
                "urlToImage": a.urlToImage ?? "",
                "publishedAt": a.publishedAt ?? "",
                "description": a.description ?? "",
                "sortBy": count ]
        }
        
        userPath.updateChildValues(dict)
    }
    
    static func getFavorite(callback: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let path = ref.child("users").child(uid).child("favorite")
        
        path.observe(.childAdded) { (snapshot) in
            guard let dict = snapshot.value as? dictionary else { return }
            Favorite.setData(with: dict) {
                  callback()
            }
        }
    }
}

extension NetworkManager {
    static func getPeopleSay(with id: String, callback: @escaping(PeopleSayArticles) -> Void) {
        let path = ref.child("peopleSay").child("posts").child(id)
        
        path.observe(.value) { (snapshot) in
            guard let dict = snapshot.value as? dictionary else { return }
            let p = PeopleSayArticles.setArticles(with: dict)
            
            callback( p )
        }
    }
}

protocol NetworkManagerDelegate {
    func requestFailed()
}


//TODO: DELETE THIS METHOD IN ALL THE CODE FLOW
//extension NetworkManager {
//    //--------------------------------------
//    //MARK: check if the user its a new user
//    //--------------------------------------
//    static func ifUserFirstTimeLogin(callback: @escaping(Bool) -> Void) {
//        //-------------------------------------------
//        //MARK: get the data from fire base data base
//        //-------------------------------------------
//        if let uid = uid {
//            let path = ref.child("users").child(uid).child("firstTimeLogin")
//            
//            path.observe(.value) { (snapshot) in
//                if let bool = snapshot.value as? Bool {
//                    
//                    if bool {
//                    callback( bool )
//                    setFirstTimeLogin()
//                    }else{
//                    callback( bool )
//                    }
//                }
//            }
//        }
//    }
//    
//    static func setFirstTimeLogin(){
//        //-------------------------------------------
//        //MARK: get the data from fire base data base
//        //-------------------------------------------
//        if let uid = uid {
//            let userPath = ref.child("users").child(uid)
//            userPath.updateChildValues(["firstTimeLogin" : false])
//        }
//    }
//}
//
