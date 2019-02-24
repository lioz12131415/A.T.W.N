//
//  SelectedCategoryExtensions.swift
//  A.T.W.N
//
//  Created by lioz balki on 20/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

extension SelectedCategoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    //-------------------------------------------------------------------------
    //MARK: UICollection View Delegate && UICollection View Data Source section
    //-------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedCategoryArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedCategoryCell", for: indexPath) as! SelectedCategoryCell
        
        let article = selectedCategoryArticles[indexPath.row]
        cell.article = article
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let articel = selectedCategoryArticles[indexPath.row]
        Controllers.performSegue(with: self, delay: 0, Identifier: .SelectedCategoryToArticle, sender: articel)
    }
}

extension SelectedCategoryVC: FixCellsHeightDelegate {
    //-----------------------------------------
    //MARK: imploment Fix Cells Height Delegate
    //-----------------------------------------
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let h = Helpers.randWith(min: 300, max: 400)
        
        return h
    }
}
