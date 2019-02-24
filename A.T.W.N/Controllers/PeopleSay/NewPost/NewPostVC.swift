//
//  NewPostVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 25/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class NewPostVC: UIViewController {
    
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postTxtView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonsStack: UIStackView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var newPostView: DesignableView!
    @IBOutlet weak var deleateImage: DesignableButton!
    
    
    @IBOutlet weak var newPostViewConst: NSLayoutConstraint!
    @IBOutlet weak var articleImageConst: NSLayoutConstraint!
    @IBOutlet weak var contanierViewConst: NSLayoutConstraint!
    
    var imageData: Data?
    var selectedImage: UIImageView?
    var correntePostTxtViewH: CGFloat = 0
    var correnteNewPostViewH: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //-----------------------------------------------
        postTxtView.delegate = self
        correnteNewPostViewH = newPostView.frame.height
        postTxtView.setPlaceHolder(with: "put text here")
        //-----------------------------------------------
        handleStartControllerConst()
        //-----------------------------------------------
        self.hideKeyboardWhenTouchAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserInfo()
    }
        
    private func handleStartControllerConst(){
        articleImageConst.constant = 0
        textViewDidChange(postTxtView)
        contanierViewConst.constant = Helpers.screenHeight
    }
    
    private func setUserInfo() {
        let user = User.user
        
        userName.text = user.name
        
        if let urlStr = user.profileImage {
            let url = URL(string: urlStr)
                userImage.sd_setImage(with: url)
        }
    }
}

extension NewPostVC: UITextViewDelegate {
    //---------------------------------------------
    ///
    //---------------------------------------------
    func textViewDidChange(_ textView: UITextView) {
        
        let fixedWidth = textView.frame.size.width
        
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height + 30)
        
        handleControllerHeight()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text != "" else {
            postTxtView.setPlaceHolder(with: "put text here")
            return
        }
    }
    
    private func handleControllerHeight() {
        
        let textH = postTxtView.frame.height
        let stackH = buttonsStack.frame.height
        let sum = ( articleImageConst.constant + textH ) + ( stackH + 76 )
        
        newPostViewConst.constant = sum
        contanierViewConst.constant = ( sum + 100 )
        
        if contanierViewConst.constant <= view.frame.height {
            contanierViewConst.constant = view.frame.height
        }
    }
}

extension NewPostVC {
    //-----------------------
    //MARK: IBAction Section
    //-----------------------
    @IBAction func addImageTouch(_ sender: UIButton) {
        Helpers.presentPikerController(with: self)
    }
    
    @IBAction func deleteImageTouch(_ sender: UIButton) {
        //----------------------------
        sender.isHidden = true
        articleImage.image = nil
        selectedImage?.image = nil
        articleImageConst.constant = 0
        //----------------------------
        textViewDidChange(postTxtView)
        //----------------------------
    }
    
    @IBAction func postTouch(_ sender: UIButton) {
        ///
        guard let text = postTxtView.text,
            postTxtView.textColor != .lightGray,
                !text.isEmpty else { return }

        if let data = articleImage.image?.jpegData(compressionQuality: 0.1) {
            imageData = data
        }
        
        //-----------------------------------------
        ProgressPopup.showProgressPopup(view: self)
        //-----------------------------------------
        NetworkManager.post(data: imageData, name: User.user.name!, postDiscrip: text, ctegory: "", profileImage: User.user.profileImage!) {
           
            ProgressPopup.hideProgressPopup() {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension NewPostVC {
    //-----------------------
    //MARK:
    //-----------------------
    func setSelectedImage(image: UIImage)  {
        //---------------------------------------
        articleImage.image = image
        selectedImage?.image = image
        deleateImage.isHidden = false
        //----------------------------------------        
        articleImageConst.constant = 350
        //----------------------------------------
        textViewDidChange(postTxtView)
        //----------------------------------------
    }
}
