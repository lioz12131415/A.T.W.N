//
//  PeopleSayExta.swift
//  A.T.W.N
//
//  Created by lioz balki on 24/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

extension PeopleSayVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peopleSayArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleSayCell", for: indexPath) as! PeopleSayCell
        
        let peopleSay = peopleSayArticles[indexPath.row]
        cell.peopleSayArtical = peopleSay
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let peopleSay = peopleSayArticles[indexPath.row]
        Controllers.performSegue(with: self, delay: 0, Identifier: .toPeopleSayArticleVC, sender: peopleSay)
    }
}

extension PeopleSayVC: FixCellsHeightDelegate {
    //-----------------------------------------
    //MARK: imploment Fix Cells Height Delegate
    //-----------------------------------------
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let h = Helpers.randWith(min: 300, max: 400)
        
        return h
    }
}
