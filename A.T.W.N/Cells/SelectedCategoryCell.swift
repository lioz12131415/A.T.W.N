//
//  TopNewsCollectionCell.swift
//  A.T.W.N
//
//  Created by lioz balki on 20/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class SelectedCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    var article: Articles? {
        didSet{
            setInfo()
        }
    }
    
    private func setInfo() {
        ///
        if let urlStr = article?.urlToImage {
            let url = URL(string: urlStr)
            articleImage.sd_setImage(with: url)
        }else{ setSourceImage(with: articleImage) }
        
        if let title = article?.title {
            articleTitle.text = title
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
