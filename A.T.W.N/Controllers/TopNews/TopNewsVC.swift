//
//  TopNewsVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 19/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class TopNewsVC: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    //--------------------------------
    var allCategories = [[Articles]]()
    //--------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        //-----------------------
        self.setCategories()
        //-----------------------
        tableView.delegate = self
        tableView.dataSource = self
        TabBarVC.topNewsDelegate = self
        //-----------------------
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
            case "topNewsToArticle":
                guard let vc = segue.destination as? ArticelVC,
                    let articel = sender as? Articles else { return }
                vc.articel = articel
            
            case "toSelectedCategory":
                guard let vc = segue.destination as? SelectedCategoryVC,
                    let articel = sender as? [Articles] else { return }
                vc.selectedCategoryArticles = articel
            
        default:
            break
        }
    }
    
     func setCategories() {
        allCategories.removeAll()
        allCategories.append(Sports.articles)
        allCategories.append(General.articles)
        allCategories.append(Business.articles)
        allCategories.append(Technology.articles)
    }
    
    private func scrollTop(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let topIndex = IndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
        }
    }
}

extension TopNewsVC: TabBarTopDelegate {
    func scrollTopNews() { scrollTop() }
}
