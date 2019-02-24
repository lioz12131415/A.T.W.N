//
//  FilterByContryPopup.swift
//  A.T.W.N
//
//  Created by lioz balki on 16/12/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import UIKit

class FilterByContryPopupVC: UIViewController {
    
    @IBOutlet weak var continerView: DesignableView!
    @IBOutlet weak var collectionView: UICollectionView!
    //---------------------------------------------------
    //MARK: all the Contry Code we can use to get sources
    /* ae-ar-at-au-be-bg-br-ca-ch-cn-co-cu-cz-de-eg-fr-gb-gr-hk-hu-id-ie-il-in-it-jp-kr-lt-lv-ma-mx-my-ng-nl-no-nz-ph-pl-pt-ro-rs-ru-sa-se-sg-si-sk-th-tr-tw-ua-us-ve-za */
    //---------------------------------------------------
    static var delegate: FilterByContryDelegate?
    fileprivate var contryCodeArr = Helpers.ContryCodeArr()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //------------------------------
        ///
        collectionView.delegate = self
        collectionView.dataSource = self
        continerView.backgroundColor = .white
        //------------------------------
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //-----------------------------------------
        //MARK: handel the execute of the animation
        guard Animation.fromBottomStatus == .start else {
            //---------------------------------------------
            //MARK: update the current position to the view
            //---------------------------------------------
           continerView.center.y = Animation.viewPositionAfter ?? 0.0
            return
        }
        //--------------------------------------------
        //MARK: start the animtion of this popup class
        Animation.viewFromButtomAnimated(with: continerView)
        //--------------------------------------------
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //---------------------------------
        //MARK: handel the animation status
        Animation.stopFromButtomAnimated()
        //---------------------------------
    }

    
    static func show(_ view: UIViewController) {
        //-------------------------------------------------
        //MARK: show this view controller on the current VC
        //-------------------------------------------------
        let controller = UIStoryboard.init(name: "Popups", bundle: nil).instantiateViewController(withIdentifier: "FilterByContryPopupVC") as! FilterByContryPopupVC
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overCurrentContext
        view.present(controller, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //-------------------------------------------
        //MARK: handel the touche on the screen began
        self.selfDismiss()
        //-------------------------------------------
    }
}

extension FilterByContryPopupVC: UICollectionViewDelegate, UICollectionViewDataSource {
    //----------------------------------------------------------------
    //MARK: UICollection View Delegate & UICollection View Data Source
    //----------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contryCodeArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterByContryCell", for: indexPath) as! FilterByContryCell
        
        let country = contryCodeArr[indexPath.row]
        cell.contryCode = country
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contry = contryCodeArr[indexPath.row]
        FilterByContryPopupVC.delegate?.didSelectedContry(contry: contry)
    }
}

extension FilterByContryPopupVC: UICollectionViewDelegateFlowLayout {
    //----------------------------------------------------
    //MARK: UICollection View Delegate Flow Layout section
    //----------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 5 - 2, height: collectionView.frame.size.height / 5 - 2)
    }
}

protocol FilterByContryDelegate {
    func didSelectedContry(contry: String)
}
