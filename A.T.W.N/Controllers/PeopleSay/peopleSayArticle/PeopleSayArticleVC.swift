//
//  peopleSayArticleVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 07/02/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

class PeopleSayArticleVC: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var articaleDiscrip: UITextView!
    
    @IBOutlet weak var articalOwnerImage: UIImageView!
    @IBOutlet weak var growingTxtView: GrowingTextView!
    @IBOutlet weak var growingView: ViewInKeyboardPosion!
    
    @IBOutlet weak var postImageConst: NSLayoutConstraint!
    @IBOutlet weak var growingViewConst: NSLayoutConstraint!
    @IBOutlet weak var contentViewConst: NSLayoutConstraint!
    @IBOutlet weak var containerViewConst: NSLayoutConstraint!
    @IBOutlet weak var gowingViewBottomConst: NSLayoutConstraint!
    @IBOutlet weak var scrollViewBottomConst: NSLayoutConstraint!
    
    
    var comments = [Comment]()
    var peopleSayArticle: PeopleSayArticles?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //---------------------------------------------------
        setUserInfo()
        setDescription()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        //---------------------------------------------------
        articaleDiscrip.isEditable = false
        growingTxtView.growingDelegate = self
        //---------------------------------------------------
        self.hideKeyboardWhenTouchAround()
        growingTxtView.setPlaceHolder(with: "Message")
        //---------------------------------------------------
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setPostImage()
        self.getComments()
    }
    
    
    fileprivate func getComments() {
        guard let postId = peopleSayArticle?.id else { return }
        
        NetworkManager.getComments(with: postId) { (comment, totalItems) in
            
            self.comments.append(comment)
            self.tableView.reloadData()
            
            let viewH = self.view.frame.height
            let scrollViewBottomConst = self.scrollViewBottomConst.constant / 2
            
            let contentSizeH = self.scrollView.contentSize.height + scrollViewBottomConst
            
            if self.comments.count > totalItems  {
                if  ( contentSizeH ) >= viewH || self.postImageConst.constant != 0 {
                    self.scrollView.scrollToBottom()
                }
            }
        }
        
        let newSize = setContentViewHeight() + tableViewHeight() + growingViewHeight()
        setScrollViewHeight( scrollNewH: newSize + 28 )
    }
    
    fileprivate func setPostImage() {
        guard let urlStr = peopleSayArticle?.urlToImage,
            !urlStr.isEmptyString() else {
            postImageConst.constant = 0
                return
        }
        
        let url = URL(string: urlStr)
        postImage.sd_setImage(with: url)
        postImageConst.constant = ( postImageConst.constant*2)
    }
    
    fileprivate func setDescription() {
        guard let description = peopleSayArticle?.description else {
            return
        }
        articaleDiscrip.text = description
    }
    
    fileprivate func setUserInfo() {
        
        if let name = peopleSayArticle?.author {
            userName.text = name
        }
        
        guard let urlStr = peopleSayArticle?.profileImage else {
            return
        }
        let url = URL(string: urlStr)
        articalOwnerImage.sd_setImage(with: url)
    }
    
    func setContentViewHeight() -> CGFloat {
        
        let paddingConst: CGFloat = 24
        let textHeight = articaleDiscrip.textHeight()
        let OwnerImageHeight = articalOwnerImage.frame.height
        let postImageConstHeight = postImageConst.constant
        
        let height = postImageConstHeight + OwnerImageHeight + textHeight + paddingConst
        
        containerViewConst.constant = height + scrollViewBottomConst.constant / 2
        return height
    }
    
    func setScrollViewHeight(scrollNewH: CGFloat) {
        contentViewConst.constant = scrollNewH + scrollViewBottomConst.constant / 2
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollNewH)
    }
    
    func tableViewHeight() -> CGFloat {
        return tableView.contentSize.height
    }
    
    func growingViewHeight() -> CGFloat {
        return growingView.frame.height
    }
}

extension PeopleSayArticleVC {
    //-----------------------------
    //MARK: UIButton Action Section
    //-----------------------------
    @IBAction func postComment(_ sender: DesignableButton) {
        guard let article = peopleSayArticle,
            !growingTxtView.text.isEmptyString() else { return }
        
        NetworkManager.postComment(with: article, senderName: User.user.name!, text: growingTxtView.text, senderImage: User.user.profileImage!)
        
        view.endEditing(true)
        growingTxtView.text = ""
        growingTxtView.textViewDidChange( growingTxtView )
    }
}

extension PeopleSayArticleVC {
    //-------------------------------------------
    //MARK: navigation bar Buttons Action Section
    //-------------------------------------------
    @IBAction func closeTouch(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func likeTouch(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func addTouch(_ sender: UIBarButtonItem) {
        guard let type = peopleSayArticle?.type else { return }
        NetworkManager.setFavorite(article: peopleSayArticle as Any, type: type)
        
        defer { FavoritePopupVC.show() }
    }
}
