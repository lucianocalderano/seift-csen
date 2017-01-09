//
//  ClubListCell.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 26/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

protocol ClubListCellDelegate: class {
    func didPhoneTapped(_ sender: ClubListCell, value: String)
    func didEmailTapped(_ sender: ClubListCell, value: String)
}

class ClubListCell: UITableViewCell {
    class func dequeue (_ tableView: UITableView, indexPath: IndexPath) -> ClubListCell {
        return tableView.dequeueReusableCell(withIdentifier: "ClubListCell", for: indexPath) as! ClubListCell
    }

    var dicData:Dictionary<String, Any> {
        set {
            self.showData(newValue.dictionary("Sportassociation"))
        }
        get {
            return [:]
        }
    }
    
    @IBOutlet private var business_name: UITextView!
    @IBOutlet private var address: UITextView!
    @IBOutlet private var activities: UITextView!
    @IBOutlet private var phone: UITextView!
    @IBOutlet private var email: UITextView!
    @IBOutlet private var imageLogo: UIImageView!

    weak var delegate:ClubListCellDelegate?
    
    private func showData(_ dic: Dictionary<String, Any>) -> Void {
        business_name.text = dic.string("business_name")
        if (business_name.text.characters.count == 0) {
            business_name.text = dic.string("username")
        }
        business_name.text = business_name.text.capitalized
        
        address.text = dic.string("address") + " " + dic.string("city").replacingOccurrences(of: "\n", with: " ")
        
        activities.text = dic.string("activities")
        phone.text = dic.string("phone")
        email.text = dic.string("email")
        imageLogo.image =  UIImage (named: "K")
        imageLogo.alpha = 0.66
        imageLogo.imageFromUrl(dic.string("image"))
    }

    @IBAction func btnPhone(_ sender: UIButton) {
        if (delegate != nil) {
            delegate?.didPhoneTapped(self, value: phone.text)
        }
    }
    @IBAction func btnEmail(_ sender: UIButton) {
        if (delegate != nil) {
            delegate?.didEmailTapped(self, value: email.text)
        }
    }
}
