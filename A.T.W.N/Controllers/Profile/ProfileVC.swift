//
//  ProfileVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 29/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet var selectedLines: [UIView]!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var favoriteViewConst: NSLayoutConstraint!
    
    var profileCollection = ProfileCollection.favorite
    
    override func viewDidLoad() {
        super.viewDidLoad()
     // ================================ //
        Favorite.delegate = self
        collectionView.delegate = self
        TabBarVC.profileDelegate = self
        collectionView.dataSource = self
     // -------------------------------- //
        FixCellsHeightLayout()
        getMyArticles()
        setUserImage()
        getData()
     // ================================ //
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "toPeopleSay" {
        guard let nav = segue.destination as? UINavigationController,
            let p = sender as? PeopleSayArticles,
                let vc = nav.topViewController as? PeopleSayArticleVC else { return }
            
            vc.peopleSayArticle = p
       
        }else if segue.identifier == "toArticel" {
            guard let vc = segue.destination as? ArticelVC,
                let a = sender as? Articles else { return }
            
            vc.articel = a
        }
    }
    
    private func setUserImage() {
        guard let urlStr = User.user.profileImage else { return }
            let url = URL(string: urlStr)
        
        profileImage.sd_setImage(with: url )
    }
    
    private func getData() {
        NetworkManager.getFavorite() {
            self.collectionView.reloadData()
            self.fixCollectionLayout()
        }
    }
    
    private func getMyArticles() {
        NetworkManager.getMyArticles {
            self.collectionView.reloadData()
            self.fixCollectionLayout()
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
    
    private func fixCollectionLayout() {
        guard let layout = self.layout() else { return }
        
        layout.collectionView?.reloadData()
        layout.contentHeight = 0
        layout.cache.removeAll()
        layout.prepare()
    }
}

extension ProfileVC: FavoriteDelegate {
    func reloadData() {
        self.collectionView.reloadData()
    }
}

extension ProfileVC: TabBarProfileDelegate {
    func favoriteViewHandle() {
        let height = view.bounds.height
        Animation.changeViewHeight( favoriteViewConst, height)
    }
}

extension ProfileVC {
    // ============================= //
    // MARK: UIButton Action Section
    // ============================= //
    @IBAction func favoriteTouch(_ sender: UIButton) {
        borderLinesHandle(lineIndex: 0)
        profileCollection = .favorite
        collectionView.reloadData()
        
        fixCollectionLayout()
    }
    
    @IBAction func myArticlesTouch(_ sender: UIButton) {
        borderLinesHandle(lineIndex: 1)
        profileCollection = .myArticles
        collectionView.reloadData()
        
        fixCollectionLayout()
    }
    
    private func borderLinesHandle(lineIndex: Int) {
        selectedLines.forEach { (line) in line.alpha = 0 }
        Animation.borderLineAnimation(line: selectedLines[lineIndex])
    }
}

public enum ProfileCollection {
    case favorite
    case myArticles
}
