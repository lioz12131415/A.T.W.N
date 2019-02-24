//
//  MainVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 02/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit
import ViewAnimator

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedCategorie: dictionary = [:]
    typealias dictionary = Dictionary< String , Any >
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //-----------------------------------
        //MARK: imploment Delegate with self
        AllArticles.delegete = self
        TabBarVC.mainDelegate = self
        SourcesPopupVC.delegate = self
        NetworkManager.delegate = self
        //-----------------------------------
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        //-----------------------------------
        tableView.delegate = self
        tableView.dataSource = self
        //-----------------------------------
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ArticelVC,
            let artical = sender as? Articles else { return }
        vc.articel = artical
    }
    
    private func closeAnimated(){
        animateExecute = .execute
        ProgressPopup.hideProgressPopup()
        scrollTop()
    }
    
    private func scrollTop(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let topIndex = IndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
        }
    }
}

//-------------------------------
//MARK: self protocols implomeant
//-------------------------------
extension MainVC: AllArticlesDelegate {
    func noDataToDisplay() { /*TODO: create alert*/ }
    
    func reloadTableData() { closeAnimated() }
}

extension MainVC: NetworkManagerDelegate {
    func requestFailed() {
        closeAnimated()
        AlertPopupVC.showAlert(view: self)
    }
}

extension MainVC: SourcesPopupVCDelegate {
    func sendSource(source: Sources) {
        ProgressPopup.showProgressPopup(view: self)
        if let id = source.id, let c = source.category {
            if let category = categories(rawValue: c) {
                NetworkManager.setArticles(categoty: category, sourceId: id)
            }
        }
    }
}

extension MainVC: TabBarMainDelegate {
    func scrollMain() { scrollTop() }
}
