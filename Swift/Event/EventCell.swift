//
//  EventCell.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 26/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    class func dequeue (_ tableView: UITableView, indexPath: IndexPath) -> EventCell {
        return tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
    }
    
    var dicData:Dictionary<String, Any> {
        set {
            self.showData(newValue.dictionary("Frontevent"))
        }
        get {
            return [:]
        }
    }
    
    @IBOutlet private var lblTitle: MYLabel!
    @IBOutlet private var lblDay: MYLabel!
    @IBOutlet private var lblMonth: MYLabel!
    @IBOutlet private var lblArea: MYLabel!
    @IBOutlet private var lblPlace: MYLabel!
    @IBOutlet private var lblNumReg: MYLabel!
    @IBOutlet private var lblType: MYLabel!
    @IBOutlet private var lblSubs: MYLabel!
    @IBOutlet private var viewDate: UIView!
    @IBOutlet private var imvLocandina: UIImageView?

    override func awakeFromNib() {
        lblArea.layer.masksToBounds = true
        lblArea.layer.cornerRadius = 5
        lblType.layer.masksToBounds = true
        lblType.layer.cornerRadius = 5
        viewDate.layer.cornerRadius = 5
    }

    
    private func showData(_ dic: Dictionary<String, Any>) -> Void {
        lblPlace.text = dic.string("place")
        lblArea.text = dic.string("challenge_area")
        
        let eventDate = dic.string("event_datetime").toDateFmt(DateFormat.fmtDb)
        lblDay.text = eventDate.toString("dd")
        lblMonth.text = eventDate.toString("MMM")

        lblNumReg.text = Lng("handlers") + " " + dic.string("subscribed") + "/" + dic.string("max_subscribers")
        
        lblTitle.text = dic.string("title")
        
        lblType.text = Challenge.title
        if Challenge.typeName == ChallengeType.None.rawValue {
            lblType.backgroundColor = ChallengeClass().getColorForType(dic.string("challenge_type"))
            lblType.text = ChallengeClass().getTitolo(dic.string("challenge_type"))
            viewDate.backgroundColor = lblType.backgroundColor
        }
        else {
            lblType.backgroundColor = Challenge.color
            viewDate.backgroundColor = Challenge.color
        }
        
        imvLocandina!.image = UIImage (named: "logoKanito")
        imvLocandina?.alpha = 0.5
        imvLocandina?.imageFromUrl(dic.string("image"))
        
        lblSubs.text = Lng("subsAreClosed")
        lblSubs.textColor = UIColor.myRed()
        
        let d = Date()
        
        let dIni = dic.string("subscription_start").toDateFmt(DateFormat.fmtDb)
        var result:ComparisonResult?
        result = d.compare(dIni)
        if (result == ComparisonResult.orderedAscending) {
            return
        }

        let dFin = dic.string("subscription_end").toDateFmt(DateFormat.fmtDb)
        result = d.compare(dFin)
        if (result == ComparisonResult.orderedDescending) {
            return
        }
        lblSubs.text = Lng("subsOpen")
        lblSubs.textColor = UIColor.myGreen()
        
    }
}

