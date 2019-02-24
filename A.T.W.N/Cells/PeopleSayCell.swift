//
//  PeopleSayCell.swift
//  A.T.W.N
//
//  Created by lioz balki on 24/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class PeopleSayCell: UICollectionViewCell {
    
    @IBOutlet weak var timeAgoLbl: UILabel!
    @IBOutlet weak var postDescrip: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    
    
    var peopleSayArtical: PeopleSayArticles? {
        didSet {
            setTimeAgo()
            setDiscrip()
            setPostImage()
            setUserImage()
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        ///
    }
    
    private func setPostImage() {
        if let urlStr = peopleSayArtical?.urlToImage {
            let url = URL(string: urlStr)
                postImage.sd_setImage(with: url)
        } else { postImage.image = UIImage(named: "no_image_Data") }
    }
    
    private func setDiscrip() {
        if let description = peopleSayArtical?.description {
             postDescrip.text = description
        }
    }
    
    private func setUserImage() {
        if let urlStr = peopleSayArtical?.profileImage {
            let url = URL(string: urlStr)
            userImage.sd_setImage(with: url)
        }
    }
    
    private func setTimeAgo() {
        if let timeInterval = peopleSayArtical?.timeInterval {
           
            guard timeInterval > 0 else {
                timeAgoLbl.text = "team post"
                return
            }
           
            let unixConvertedDate = Date(timeIntervalSince1970: timeInterval)
            let time = unixConvertedDate.getElapsedInterval()
            timeAgoLbl.text = time
        }
    }
}
