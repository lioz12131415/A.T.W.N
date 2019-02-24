//
//  HeaderCell.swift
//  A.T.W.N
//
//  Created by lioz balki on 20/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var sectionLbl: UILabel!
    
    //---------------------------
    var section: Int?
    var delegate: HeaderDelegate?
    //---------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //-------------------------
        //MARK: Initialization code
        //-------------------------
    }
}

extension HeaderCell {
    //-------------------------
    //UIButton IBAction Section
    //-------------------------
    @IBAction func moreTouch(_ sender: UIButton) {
        if let section = section {
            delegate?.didTapMore(section: section)
        }
    }
}

protocol HeaderDelegate {
    //----------------
    //protocol Section
    //----------------
    func didTapMore(section: Int)
}
