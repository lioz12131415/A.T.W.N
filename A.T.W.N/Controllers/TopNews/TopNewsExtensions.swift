//
//  TopNewsExtensions.swift
//  A.T.W.N
//
//  Created by lioz balki on 19/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit


extension TopNewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let cell = Bundle.main.loadNibNamed("Header", owner: self, options: nil)?.first as! HeaderCell
        
        switch section {
            case 0: cell.sectionLbl.text = categories.sports.str
            case 1: cell.sectionLbl.text = categories.general.str
            case 2: cell.sectionLbl.text = categories.business.str
            case 3: cell.sectionLbl.text = categories.technology.str
        default:
           break
        }
        
        cell.delegate = self
        cell.section = section
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(55)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopNewsCell", for: indexPath) as! TopNewsCell
        
        if allCategories[indexPath.section].count > 0 {
            
            let article = allCategories[indexPath.section][indexPath.row]
            cell.article = article
            cell.selectionStyle = .none
        
        } else {
            setCategories()
            self.tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentArticel = allCategories[indexPath.section][indexPath.row]
        Controllers.performSegue(with: self, delay: 0, Identifier: .topNewsToArticle, sender: currentArticel)
    }
}

extension TopNewsVC: HeaderDelegate {
    func didTapMore(section: Int) {
        //---------------------------------------------------
        let selectedCategoryArticles = allCategories[section]
        //---------------------------------------------------
        Controllers.performSegue(with: self, delay: 0, Identifier: .toSelectedCategory, sender: selectedCategoryArticles)
    }
}
