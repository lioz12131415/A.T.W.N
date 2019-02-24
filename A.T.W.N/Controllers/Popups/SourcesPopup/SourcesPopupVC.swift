//
//  SourcesPopupVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 05/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class SourcesPopupVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sources = [Sources]()
    static var delegate: SourcesPopupVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        self.dissmisViewWhenTouch()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animatedExecute = .execute
    }
}

protocol SourcesPopupVCDelegate {
    func sendSource(source: Sources)
}
