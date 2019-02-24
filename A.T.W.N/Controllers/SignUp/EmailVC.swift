//
//  EmailVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 11/01/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

class EmailVC: UIViewController {
    
    @IBOutlet weak var emailTxtF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? NameVC,
            let email = sender as? String else { return }
        
        vc.email = email
    }
}

extension EmailVC {
    //-----------------------------
    //MARK: UIButton Action Section
    //-----------------------------
    @IBAction func closeTouch(_ sender: UIButton) {
        self.selfDismiss()
    }
    
    @IBAction func nextTouch(_ sender: UIButton) {
        guard let email = emailTxtF.text, email.isValidEmail() else { return }
            Controllers.performSegue(with: self, delay: 1, Identifier: .toNameVC, sender: email)
        
    }
}
