//
//  TopNewsCell.swift
//  A.T.W.N
//
//  Created by lioz balki on 19/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class TopNewsCell: UITableViewCell {
    
    @IBOutlet weak var publishAtLbl: UILabel!
    @IBOutlet weak var articleTitleLbl: UILabel!
    @IBOutlet weak var sourceImage: UIImageView!
    @IBOutlet weak var articleImage: UIImageView!

    var article: Articles? {
        didSet {
            setInfo()
        }
    }
    
    private func setInfo(){
        
        if let urlStr = article?.urlToImage {
            
            let url = URL(string: urlStr)
            articleImage.sd_setImage(with: url) { (img, err, type, url) in
                if err != nil { self.setSourceImage(with: self.articleImage) }
            }
            
        } else {
            setSourceImage(with: articleImage)
        }
        
        if let title = article?.title {
            articleTitleLbl.text = title
        }
        
        setSourceImage(with: sourceImage)
        
        if let publishedAt = article?.publishedAt {
            let time = publishedAt.dateFromTimestamp?.getElapsedInterval()
            publishAtLbl.text = time
        }
    }
    
    func setSourceImage(with image: UIImageView){
        if let source = article?.source?.id {
            let urlStr = NetworkManager.getSourceNewsLogoUrl(source: source)
            let url = URL(string: urlStr)
            image.sd_setImage(with: url)
        }
    }
}
