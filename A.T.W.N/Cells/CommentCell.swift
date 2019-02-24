//
//  commentCell.swift
//  A.T.W.N
//
//  Created by lioz balki on 07/02/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var containerView: DesignableView!
    
    var comment: Comment? {
        didSet {
            setInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.isEditable = false
    }
    
    fileprivate func setInfo() {
        if let name = comment?.senderName {
            userName.text = name
        }
        
        if let text = comment?.text {
            textView.text = text
        }
        
        if let urlStr = comment?.senderImage {
            let url = URL(string: urlStr)
            userImage.sd_setImage(with: url)
        }
    }
}
