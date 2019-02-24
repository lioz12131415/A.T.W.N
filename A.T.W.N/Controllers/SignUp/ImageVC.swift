//
//  ImageVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 11/01/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

class ImageVC: UIViewController {
    
    @IBOutlet weak var addImageBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    var arr = [String]()
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        Helpers.addTapGusterImageView(with: profileImage, target: self, selector: #selector(handleImageTaps))
    }
    
    @objc func handleImageTaps() {
        Helpers.presentPikerController(with: self)
    }
}

extension ImageVC {
    //-----------------------------
    //MARK: UIButton Action Section
    //-----------------------------
    @IBAction func closeTouch(_ sender: UIButton) {
        self.selfDismiss()
    }
    
    @IBAction func addImageTouch(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        Helpers.presentPikerController(with: self)
    }
    
    @IBAction func finishTouch(_ sender: UIButton) {
        guard let image = selectedImage,
            let data = image.jpegData(compressionQuality: 0.1) else { return }
        
        ProgressPopup.showProgressPopup(view: self)
        
        let name = arr[1]
        let email = arr[0]
        
        NetworkManager.signUpUser(with: data, name, email) {
            AuthService.userSignUpStatus()
            ProgressPopup.hideProgressPopup()
            Controllers.performSegue(with: self, delay: 0, Identifier: .toTabBar, sender: nil)
        }
    }
    
    func setSelectedImage(image: UIImage)  {
        //----------------------------------------
        selectedImage = image
        profileImage.image = image
        //----------------------------------------
        addImageBtn.isHidden = true
    }
}

extension ImageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //--------------------------------------------------
    //MARK: extension on this file for more cleaner code
    //--------------------------------------------------
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage{
            setSelectedImage(image: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
}
