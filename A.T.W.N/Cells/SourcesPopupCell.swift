//
//  SourcesPopupCell.swift
//  A.T.W.N
//
//  Created by lioz balki on 05/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class SourcesPopupCell: UITableViewCell {
    
    @IBOutlet weak var sourceBtn: DesignableButton!
    
    var delegate: SourcesPopupCellDelegate?

    var source: Sources? {
        didSet{
            setInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setInfo() {
        if let name = source?.name {
            sourceBtn.setTitle("    #\(name)       ", for: .normal)
        }
    }
}

extension SourcesPopupCell {
    //------------------------------
    //MARK: UIButtons action section
    //------------------------------
    @IBAction func sourceTouch(_ sender: Any) {
        if let source = source {
        delegate?.didSelectSource(sources: source)
        }
    }
}

protocol SourcesPopupCellDelegate {
    func didSelectSource(sources: Sources)
}
