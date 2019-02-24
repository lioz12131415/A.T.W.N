//
//  NewPostExta.swift
//  A.T.W.N
//
//  Created by lioz balki on 25/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

extension NewPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
