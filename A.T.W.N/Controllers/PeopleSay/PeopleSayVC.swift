//
//  PeopleSayVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 24/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class PeopleSayVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var peopleSayArticles = [PeopleSayArticles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        collectionView.delegate = self
        collectionView.dataSource = self
        //---------------------------
          FixCellsHeightLayout()
                getData()
        //---------------------------
    }
    
    private func getData() {
        NetworkManager.getPeopleSay { (people) in
            self.peopleSayArticles.append(people)
                    self.collectionView.reloadData()
                        self.sortTheArray()
            
            guard let layout = self.layout() else { return }
            
            layout.collectionView?.reloadData()
            layout.cache.removeAll()
            layout.prepare()
        }
    }
    
    private func FixCellsHeightLayout() {
        guard let layout = layout() else { return }
        //---------------------------
            layout.delegate = self
        //---------------------------
    }
    
    private func layout() -> FixCellsHeight? {
        guard let layout = collectionView.collectionViewLayout as? FixCellsHeight else {
            return nil
        }
            return layout
    }
    
    private func sortTheArray() {
        self.peopleSayArticles.sort(by: { (left, right) -> Bool in
            left.timeInterval ?? 0 > right.timeInterval ?? 0
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController,
            let vc = nav.topViewController as? PeopleSayArticleVC,
                let peopleSay = sender as? PeopleSayArticles else { return }
        
        vc.peopleSayArticle = peopleSay
    }
}

extension PeopleSayVC {
    //-----------------------------
    //MARK: UIButton Action Section
    //-----------------------------
    @IBAction func newPostTouch(_ sender: UIButton) {
        AuthService.checkIfUserSignUp { (bool) in
            if bool {
                Controllers.performSegue(with: self, delay: 0, Identifier: .toNewPostVC, sender: nil)
            }else { SignUpVC.show() }
        }
    }
}
