//
//  MainExtension.swift
//  A.T.W.N
//
//  Created by lioz balki on 02/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit
import ViewAnimator

var allNecessarySources = [Sources]()
var animateExecute = AnimatedExecute.execute
let categorieArr = categories.categoriesArr()


extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorieArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        let c = categorieArr[indexPath.row]
        cell.category = c
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        allNecessarySources.removeAll()
        
        switch categorieArr[indexPath.row] {
        
        case .sports: switchCategoey(categoey: .sports)
        case .health: switchCategoey(categoey: .health)
        case .science: switchCategoey(categoey: .science)
        case .general: switchCategoey(categoey: .general)
        case .business: switchCategoey(categoey: .business)
        case .technology: switchCategoey(categoey: .technology)
        case .entertainment: switchCategoey(categoey: .entertainment)

        }
    }
    
    func switchCategoey(categoey: categories){
        if let sources =  AllArticles.sources {
            for source in sources {
                if source.category == categoey.str {
                    allNecessarySources.append(source)
                }
            }
            Controllers.showSourcesPopup(view: self)
        }
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width / 3 , height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllArticles.articles.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
                
        let a = AllArticles.articles[indexPath.row]
        cell.article = a
        cell.selectionStyle = .none
        
        if animateExecute == .execute {
            Animation.rowOneAfterOne(with: self.tableView, direction: .top)
            animateExecute = .unExecuted
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentArticel = AllArticles.articles[indexPath.row]
        Controllers.performSegue(with: self, delay: 0, Identifier: .mainToArticel, sender: currentArticel)
    }
}
