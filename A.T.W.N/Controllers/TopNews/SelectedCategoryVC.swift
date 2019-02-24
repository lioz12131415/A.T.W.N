//
//  TopNewsCollectionVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 20/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class SelectedCategoryVC: UIViewController {
    
    var selectedCategoryArticles = [Articles]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //-----------------------------------
        if let layout = collectionView.collectionViewLayout as? FixCellsHeight {
            layout.delegate = self
        }
        //-----------------------------------
        collectionView.delegate = self
        collectionView.dataSource = self
        //-----------------------------------
    }
    
    ///
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ArticelVC,
            let artice = sender as? Articles else { return }
        
        vc.articel = artice
    }
}


//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    TODO: delete SelectedCategoryFirstArticle.show
//        //-----------------------------------
//        SelectedCategoryFirstArticle.show()
//        //-----------------------------------
//    }
