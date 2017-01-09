//
//  BinomiCell.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 26/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

class UserSubscriptionCell: UITableViewCell {
    class func dequeue (_ tableView: UITableView, indexPath: IndexPath) -> UserSubscriptionCell {
        return tableView.dequeueReusableCell(withIdentifier: "UserSubscriptionCell", for: indexPath) as! UserSubscriptionCell
    }
    var dicData:Dictionary<String, Any> {
        set {
            self.showData(newValue)
        }
        get {
            return [:]
        }
    }

    @IBOutlet private var bin: MYLabel!
    @IBOutlet private var tit: MYLabel!
    @IBOutlet private var loc: MYLabel!
    @IBOutlet private var dat: MYLabel!
    @IBOutlet private var lev: MYLabel!

    
    private func showData(_ dicData: Dictionary<String, Any>) -> Void {
        bin.text = dicData.string("Binomial.binomial") + " " +  dicData.string("Binomial.dog")
        tit.text = dicData.string("Frontevent.title")
        loc.text = dicData.string("Frontevent.place")
        dat.text = dicData.string("Frontevent.event_datetime")

        lev.text = dicData.string("Software_level.name") + " " +
                   dicData.string("Software_height.name") + " " +
                   dicData.string("RallyRank.name") + " " +
                   dicData.string("CaniCrossLevel.name") + " " +
                   dicData.string("CaniCrossCategory.name")
    }
}
