//
//  SourcesPopupExtension.swift
//  A.T.W.N
//
//  Created by lioz balki on 05/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

typealias dictionary = Dictionary< String , Any >

var animatedExecute = AnimatedExecute.execute


extension SourcesPopupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourcesPopupCell", for: indexPath) as! SourcesPopupCell
        
        let s = sources[indexPath.row]
        cell.source = s
        cell.delegate = self
        cell.selectionStyle = .none
        
        if animatedExecute == .execute {
            Animation.rowOneAfterOne(with: self.tableView, direction: .left)
            animatedExecute = .unExecuted
        }
        
        return cell
    }
}

extension SourcesPopupVC: SourcesPopupCellDelegate {
    //------------------------------------------------------------------
    //MARK: extension current VC with SourcesPopupCellDelegate protocols
    //------------------------------------------------------------------
    func didSelectSource(sources: Sources) {
        
        if let id = sources.id {
        Helpers.setLastSource(with: id)
        }
        
        SourcesPopupVC.delegate?.sendSource(source: sources)
        self.dismiss(animated: true, completion: nil)
    }
}
