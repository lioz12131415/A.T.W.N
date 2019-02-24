//
//  peopleSayArticleExten.swift
//  A.T.W.N
//
//  Created by lioz balki on 08/02/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit


extension PeopleSayArticleVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        
        let comment = comments[indexPath.row]
        cell.selectionStyle = .none
        cell.comment = comment
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let txt = UITextView()
        let w = tableView.frame.width
        let h = tableView.frame.height
        
        txt.frame.size = CGSize(width: w, height: h)
       
        txt.text = self.comments[indexPath.row].text
        
        let newSize = setContentViewHeight() + tableViewHeight() + growingViewHeight()
        setScrollViewHeight( scrollNewH: newSize + 28 )
                
         return (txt.textHeight() * 2) + scrollViewBottomConst.constant
    }
}

extension PeopleSayArticleVC: GrowingDelegate {
    func heightChange(height: CGFloat) {
        growingViewConst.constant = ( height )
    }
}
