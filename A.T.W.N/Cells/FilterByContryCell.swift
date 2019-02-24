//
//  FilterByContryCell.swift
//  A.T.W.N
//
//  Created by lioz balki on 16/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class FilterByContryCell: UICollectionViewCell {
    
    @IBOutlet weak var contryCodeBtn: DesignableButton!
    
    var contryCode: String? {
        didSet{
            setInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //
    }
    
    func setInfo(){
        if let contryCode = contryCode {
             contryCodeBtn.setTitle(contryCode, for: .normal)
        }
    }
}

extension FilterByContryCell {
    //TODO: delete this IBAction..
    @IBAction func contryCodeTouch(_ sender: Any) {
    }
}
