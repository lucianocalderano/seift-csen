//
//  MyViewController.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 26/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

class MyContainerHeaderView: UIView {
    private var savedTitle = ""
    @IBInspectable var titolo: String {
        set {
            if (newValue.isEmpty) {
                return
            }
            savedTitle = newValue.tryLang()
        }
        get {
            return savedTitle
        }
    }

    @IBInspectable var optionIcon: UIImage?
}

class MyViewController: UIViewController, MyHeaderViewDelegate {
    var headerTitle:String {
        set {
            self.myHeader.titleLabel.text = newValue.tryLang()
        }
        get {
            return self.myHeader.titleLabel.text!
        }
    }
    
    @IBOutlet private var containerHeaderView: MyContainerHeaderView!
    var dataArray: Array = [Any]()
    var myHeader = MyHeaderView.instanceFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("\n<<<" + StringFromClass(type(of: self)) + ">>>\n")
        self.view.backgroundColor = UIColor.white
        self.navigationController!.navigationBar.shadowImage = nil

        if containerHeaderView != nil {
            myHeader.addToContainer(containerHeaderView)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myHeader.delegate = self
        guard self.containerHeaderView.optionIcon != nil else {
            return
        }
        let img = self.containerHeaderView.optionIcon
        self.myHeader.optionButton.setBackgroundImage(img, for: UIControlState.normal)
    }
    
    func backToRoot() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func myHeaderBackButtonTapped() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func myHeaderOptionButtonTapped () {
        print("myHeaderOptionButtonTapped")
    }
}
