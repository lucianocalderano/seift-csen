//
//  BinomiCtrl.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit
class RankShowCtrl: MyViewController {
    class func instanceFromSb (_ sb: UIStoryboard!) -> RankShowCtrl {
        return sb.instantiateViewController(withIdentifier: "RankShowCtrl") as! RankShowCtrl
    }

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var title = ""
        switch Challenge.typeName {
        case ChallengeType.Agil.rawValue:
            title = "#rankTitleA"
        case ChallengeType.Rall.rawValue:
            title = "#rankTitleC"
        case ChallengeType.Cros.rawValue:
            title = "#rankTitleR"
        default:
            break
        }
        self.headerTitle = title
    }
    
    // MARK: table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = RankShowCell.dequeue(tableView, indexPath: indexPath)
        cell.dicData = self.dataArray[indexPath.row] as! Dictionary<String, Any>
        cell.posizione = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

