//
//  ResultsCell
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit
class ResultsCtrl: MyViewController, AreaCtrlDelegate {
    @IBOutlet private var tableView: UITableView!
    
    var numPage = 1
    var maxRecords = 50
    var areaId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.myHeader.optionButton.isHidden = Challenge.typeName.isEmpty
        self.loadData()
    }
    
    func loadData(){
        let request =  MYHttpRequest.base("challenges-results")
        request.json = [
            "page"          : numPage,
            "maxrecords"    : maxRecords,
            "type"          : Challenge.key,
            "challenge_type": Challenge.typeName,
            "challenge_area": self.areaId,
        ]
        request.start() { (success, response) in
            if success {
                self.httpResponse(response)
            }
        }
    }
    
    func httpResponse(_ resultDict: Dictionary<String, Any>) {
        self.dataArray = resultDict.array("results")
        self.tableView.reloadData()
    }
    
    // MARK: table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = ResultsCell.dequeue(tableView, indexPath: indexPath)
        cell.dicData = self.dataArray[indexPath.row] as! Dictionary<String, Any>
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! ResultsCell
        
        UIGraphicsBeginImageContextWithOptions(cell.frame.size, false, 0)
        cell.drawHierarchy(in: cell.bounds, afterScreenUpdates: true)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let dic = self.dataArray[indexPath.row] as! Dictionary<String, Any>
        if Challenge.typeName.isEmpty {
            ChallengeClass().setChallengeClassWithType(dic.string("SoftwareCompetition.type"))
        }
        
        let ctrl = self.storyboard!.instantiateViewController(withIdentifier: "ResultsTypeCtrl") as! ResultsTypeCtrl
        ctrl.headerImage = image
        ctrl.competitionId = dic.int("SoftwareCompetition.id")
        self.navigationController?.show(ctrl, sender: self)
    }
    
    override func myHeaderOptionButtonTapped() {
        let ctrl = AreaCtrl ()
        ctrl.delegate = self
        self.navigationController?.show(ctrl, sender: self)
    }

    func didSelectedArea(_ sender: AreaCtrl, selectedAreaId: String) {
        self.areaId = selectedAreaId
        self.loadData()
    }

}

