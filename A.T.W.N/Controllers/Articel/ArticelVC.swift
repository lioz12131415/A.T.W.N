//
//  ArticelVC.swift
//  A.T.W.N
//
//  Created by lioz balki on 04/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit
import WebKit

class ArticelVC: UIViewController, WKNavigationDelegate{
    
    @IBOutlet var topView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var sourceImage: UIImageView!
    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet var      arrowImagesArray: [UIImageView]!
    

    public var articel: Articles?
    public let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //--------------------------------
        setNavRightButton()
        //--------------------------------
        setInfo()
        //--------------------------------
        webView.navigationDelegate = self
        //--------------------------------
        Animation.startArrowAimation(with: arrowImagesArray)
        //--------------------------------
        Helpers.addPanGestureUIView(with: view, target: self, selector: #selector(wasDragged(gestureRecognizer:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ///
        Helpers.changeImagesColor(arrowImagesArray)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        backgroundImage.image = nil
        Animation.hideArrowAimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let w = view.frame.width
        let h = view.frame.height
        
        topView.frame = CGRect(x: 0, y: 0, width: w, height: h - 50)
        topView.center.y = (h + h / 2)
        topView.center.x = view.center.x
        
        view.addSubview(topView)
    }
    
    private func setInfo(){
        
        if let sourceId = articel?.source?.id {
            let urlStr = NetworkManager.getSourceNewsLogoUrl(source: sourceId)
                let url = URL(string: urlStr)
                    sourceImage.sd_setImage(with: url)
        }
        
        if let urlStr = articel?.urlToImage {
            let url = URL(string: urlStr)
            backgroundImage.sd_setImage(with: url)
        }else{
            setSourceImage(with: backgroundImage)
            backgroundImage.contentMode = UIView.ContentMode.scaleAspectFit
        }
        
        if let title = articel?.title {
            titleLbl.text = title
        }
        
        if let author = articel?.author {
            authorLbl.text = "By \(author)"
        }
        
        if let description = articel?.description {
            descriptionLbl.text = description
        }
    }
    
    func setSourceImage(with image: UIImageView){
        if let source = articel?.source?.id {
            let urlStr = NetworkManager.getSourceNewsLogoUrl(source: source)
            let url = URL(string: urlStr)
            image.sd_setImage(with: url)
        }
    }
    
    private func setNavRightButton() {
        let btn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButtonTouch))
        
        self.navigationItem.rightBarButtonItem  = btn
    }
    
    @objc private func barButtonTouch() {
        guard let type = articel?.type else { return }
        NetworkManager.setFavorite(article: articel as Any, type: type)
        
        defer { FavoritePopupVC.show() }
    }
}

extension ArticelVC {
    //----------------------
    //MRK: WKWebView section
    //----------------------
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        ProgressPopup.hideProgressPopup()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ProgressPopup.hideProgressPopup()
    }
}
