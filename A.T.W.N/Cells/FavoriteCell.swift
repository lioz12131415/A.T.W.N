//
//  FavoriteCell.swift
//  A.T.W.N
//
//  Created by lioz balki on 10/02/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleDiscrip: UILabel!
    
    var peopleSayArticle: PeopleSayArticles? {
        didSet {
            setDiscrip()
            setPostImage()
        }
    }
    
    var article: Articles?{
        didSet{
            setInfo()
        }
    }
    
    var myArticles: MyArticles? {
        didSet{
            setMyArticles()
        }
    }
}

extension FavoriteCell {
    private func setMyArticles() {
        
        if let description = myArticles?.description {
            articleDiscrip.text = description
        }
        
        if let urlStr = myArticles?.urlToImage {
            let url = URL(string: urlStr)
            articleImage.sd_setImage(with: url)
        }else { articleImage.image = UIImage(named: "no_image_Data") }
    }
}

extension FavoriteCell {
    
   private func setInfo(){
        
        if let urlStr = article?.urlToImage {
            let url = URL(string: urlStr)
            articleImage.sd_setImage(with: url)
        } else {
            setSourceImage(with: articleImage)
        }
        
        if let title = article?.title {
            articleDiscrip.text = title
        }
    
        setSourceImage(with: articleImage)
    }
    
   private func setSourceImage(with image: UIImageView){
        if let source = article?.source?.id {
            let urlStr = NetworkManager.getSourceNewsLogoUrl(source: source)
            let url = URL(string: urlStr)
            image.sd_setImage(with: url)
        }
    }
}

extension FavoriteCell {
    private func setPostImage() {
        if let urlStr = peopleSayArticle?.urlToImage {
            guard !urlStr.isEmptyString() else {
                articleImage.image = UIImage(named: "no_image_Data")
                    return
            }
            
            let url = URL(string: urlStr)
            articleImage.sd_setImage(with: url)
        }
    }
    
    private func setDiscrip() {
        if let description = peopleSayArticle?.description {
            articleDiscrip.text = description
        }
    }
}
