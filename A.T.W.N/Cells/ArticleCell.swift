//
//  ArticleCell.swift
//  A.T.W.N
//
//  Created by lioz balki on 02/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleCell: UITableViewCell {
   
    @IBOutlet weak var articleTitleLbl: UILabel!
    @IBOutlet weak var sourceImage: UIImageView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articlePublishTime: UILabel!
    
    
    var article: Articles?{
        didSet{
            setInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setInfo(){
        
        if let urlStr = article?.urlToImage {
            let url = URL(string: urlStr)
            articleImage.sd_setImage(with: url)
        } else {
            setSourceImage(with: articleImage)
        }
        
        if let title = article?.title {
            articleTitleLbl.text = title
        }
        
        setSourceImage(with: sourceImage)
        
        if let publishedAt = article?.publishedAt {
            let time = publishedAt.dateFromTimestamp?.getElapsedInterval()
            articlePublishTime.text = time
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
