//
//  ResultsCell
//  CsenCinofilia
//
//  Created by Luciano Calderano on 26/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {
    class func dequeue (_ tableView: UITableView, indexPath: IndexPath) -> ResultsCell {
        return tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as! ResultsCell
    }
    
    var dicData:Dictionary<String, Any> {
        set {
            self.showData(newValue.dictionary("SoftwareCompetition"))
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
    @IBOutlet private var lblNum: MYLabel!
    @IBOutlet private var lblType: MYLabel!
    @IBOutlet private var viewDate: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblArea.layer.masksToBounds = true
        lblArea.layer.cornerRadius = 5
        lblType.layer.masksToBounds = true
        lblType.layer.cornerRadius = 5
        viewDate.layer.cornerRadius = 5
    }

    private func showData(_ dic: Dictionary<String, Any>) -> Void {
        lblArea.text = dic.string("area").capitalized
        lblTitle.text = dic.string("name")
        lblPlace.text = dic.string("place")
        lblNum.text = Lng("resuPart") + ": " + dic.string("subscribed")
        
        let eventDate = dic.string("dateTime").toDateFmt(DateFormat.fmtDb)
        lblDay.text = eventDate.toString("dd")
        lblMonth.text = eventDate.toString("MMM")
        
        if Challenge.typeName.isEmpty {
            viewDate.backgroundColor = ChallengeClass().getColorForType(dic.string("type"))
            lblType.text = ChallengeClass().getTitolo(dic.string("type"))
        }
        else {
            viewDate.backgroundColor = Challenge.color
            lblType.text = Challenge.title
        }
        lblType.backgroundColor = viewDate.backgroundColor
    }
}
