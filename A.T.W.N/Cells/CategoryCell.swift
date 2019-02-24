//
//  CategoriesCell.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 30/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    var category: categories? {
        didSet{
            setInfo()
        }
    }
    
    func setInfo(){
        if let txt = category?.rawValue {
        title.text = txt
        }
    }
}
