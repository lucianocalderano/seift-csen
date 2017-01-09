//
//  ClubListCell.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 26/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {
    class func dequeue (_ tableView: UITableView, indexPath: IndexPath) -> UserProfileCell {
        return tableView.dequeueReusableCell(withIdentifier: "UserProfileCell", for: indexPath) as! UserProfileCell
    }
    
    @IBOutlet var title: MYLabel!
    @IBOutlet var descr: MYLabel!
}
