//
//  BinomiCell.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 26/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

class RankShowCell: UITableViewCell {
    class func dequeue (_ tableView: UITableView, indexPath: IndexPath) -> RankShowCell {
        return tableView.dequeueReusableCell(withIdentifier: "RankShowCell", for: indexPath) as! RankShowCell
    }

    var posizione:Int {
        set {
            self.showPosizione(newValue + 1)
        }
        get {
            return 0
        }
    }
    var dicData:Dictionary<String, Any> {
        set {
            self.showData(newValue)
        }
        get {
            return [:]
        }
    }

    private struct ChallengeDescription {
        var name = ""
        var score = ""
        var color = UIColor.white
        var time = ""
    }

    @IBOutlet private var classifica: MYLabel!
    @IBOutlet private var name: MYLabel!
    @IBOutlet private var binomial: MYLabel!
    @IBOutlet private var dog: MYLabel!
    @IBOutlet private var associazione: MYLabel!
    @IBOutlet private var score: MYLabel!
    @IBOutlet private var time: MYLabel!
    
    override func awakeFromNib() {
        classifica.text = ""
        classifica.layer.cornerRadius = 5
        classifica.layer.masksToBounds = true
        
        score.layer.cornerRadius = 5
        score.layer.masksToBounds = true
    }
    
    func showPosizione(_ posizione: Int) -> Void {
        classifica.text = String(posizione)
    }
    
    func showData(_ dic: Dictionary<String, Any>) -> Void {
        name.text = dic.string ("Binomial.name") + " " + dic.string ("Binomial.last_name")
        binomial.text = dic.string ("Binomial.binomial")
        dog.text = dic.string ("Binomial.dog").capitalized
        
        var data = ChallengeDescription()

        switch Challenge.typeName {
        case ChallengeType.Agil.rawValue:
            data.name = dic.string ("Championship.associazione")
            data.score = dic.string ("Championship.punteggio")
            data.color = UIColor.myGreen()
            data.time = ""
            
        case ChallengeType.Rall.rawValue:
            var key = ""
            for s in dic.keys {
                if s != "Binomial" {
                    key = s
                    break
                }
            }
            data.name = dic.string (key + ".association")
            data.score = dic.string (key + ".score")
            data.color = UIColor.myRed()
            data.time = (key + ".time") + " sec."
            
        case ChallengeType.Cros.rawValue:
            data.name = dic.string ("CanicrossClassification.association")
            data.score = dic.string ("CanicrossClassification.score")
            data.color = UIColor.myOrange()
            data.time = dic.string ("CanicrossClassification.time")
        default:
            break
        }
        associazione.text = data.name
        score.text = data.score
        score.backgroundColor = data.color
        time.text = data.time
    }
}
