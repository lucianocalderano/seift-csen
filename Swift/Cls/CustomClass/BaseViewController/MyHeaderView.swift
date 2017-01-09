//
//  MyViewController.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 26/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

protocol MyHeaderViewDelegate: class {
    func myHeaderOptionButtonTapped()
    func myHeaderBackButtonTapped()
}

class MyHeaderView: UIView {
    class func instanceFromNib() -> MyHeaderView {
        let nib = UINib(nibName: "MyHeaderView", bundle: nil)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! MyHeaderView
        
        return nibView
    }
    
    @IBOutlet var titleLabel: MYLabel!
    @IBOutlet var optionButton: UIButton!
    @IBOutlet var backButton: UIButton!

    var delegate: MyHeaderViewDelegate?

    func InstanceHeaderView() -> MyHeaderView {
        let xibName = String(describing: MyHeaderView())
        let objects = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)! as! Array<UIView>
        let xibView = objects.first
        return xibView as! MyHeaderView
    }
    
    func addToContainer(_ container: MyContainerHeaderView) {
        container.addSubview(self)
        self.frame = container.bounds
        titleLabel?.text = container.titolo
        optionButton?.isHidden = container.optionIcon == nil
    }
    
    @IBAction func backTapped() {
        if (self.delegate != nil) {
            self.delegate!.myHeaderBackButtonTapped()
        }
    }

    @IBAction func myHeaderOptionButtonTapped() {
        if (self.delegate != nil) {
            self.delegate!.myHeaderOptionButtonTapped()
        }
    }
}
