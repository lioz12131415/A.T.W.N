//
//  NameVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 11/01/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

class NameVC: UIViewController {
    
    @IBOutlet weak var nameTxtF: UITextField!
    
    var email: String?
    var arr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let email = email {
            arr.append(email)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ImageVC,
            let arr = sender as? Array<String> else { return }
        
        vc.arr = arr
    }
}

extension NameVC {
    //-----------------------------
    //MARK: UIButton Action Section
    //-----------------------------
    @IBAction func closeTouch(_ sender: UIButton) {
        self.selfDismiss()
    }
    
    @IBAction func nextTouch(_ sender: UIButton) {
        //-----------------------------
        guard let name = nameTxtF.text else { return }
        //-----------------------------
        arr.append(name)
        //-----------------------------
        Controllers.performSegue(with: self, delay: 0, Identifier: .toImageVC, sender: arr)
        //-----------------------------
    }
}
