//
//  ProfileExtan.swift
//  A.T.W.N
//
//  Created by lioz balki on 29/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch profileCollection {
            case .favorite: return Favorite.favoriteArr.count
            case .myArticles: return MyArticles.myArticlesArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        
        guard profileCollection == .favorite else {
            let m = MyArticles.myArticlesArr[indexPath.row]
            cell.myArticles = m
            return cell
        }
        
        if let peopleSayArticle = Favorite.peopleSayArticle(Favorite.favoriteArr[indexPath.row]) {
            cell.peopleSayArticle = peopleSayArticle
        }else if let article = Favorite.article(Favorite.favoriteArr[indexPath.row]) {
            cell.article = article
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // =============================================== //
           let index = Favorite.favoriteArr[indexPath.row]
        // =============================================== //
        
        guard profileCollection == .favorite else  {
            
            let m = MyArticles.myArticlesArr[indexPath.row]
            var p = PeopleSayArticles()
            
            p.id = m.id
            p.title = m.title
            p.author = m.author
            p.category = m.category
            p.urlToImage = m.urlToImage
            p.description = m.description
            p.timeInterval = m.timeInterval
            p.profileImage = m.profileImage
            
            Controllers.performSegue(with: self, delay: 0,
                                     Identifier: .toPeopleSay, sender: p)
                return
        }
        
        if let p = Favorite.peopleSayArticle( index ) {
            //-----------------------------------------------
             Controllers.performSegue(with: self, delay: 0,
                                      Identifier: .toPeopleSay, sender: p)
            //-----------------------------------------------
        } else if let a = Favorite.article( index ) {
            //-----------------------------------------------
            Controllers.performSegue(with: self, delay: 0,
                                     Identifier: .toArticel, sender: a)
            //-----------------------------------------------
        }
    }
}

extension ProfileVC: FixCellsHeightDelegate {
    //-----------------------------------------
    //MARK: imploment Fix Cells Height Delegate
    //-----------------------------------------
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let h = Helpers.randWith(min: 200, max: 250)
        return h
    }
}
