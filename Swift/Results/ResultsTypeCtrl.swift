//
//  ResultsTypeCtrl
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit
class ResultsTypeCtrl: MyViewController {
    class func instanceFromSb (_ sb: UIStoryboard!) -> ResultsTypeCtrl {
        return sb.instantiateViewController(withIdentifier: "ResultsTypeCtrl") as! ResultsTypeCtrl
    }
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var headerImageView: UIImageView!
    
    var headerImage:UIImage? = nil
    var competitionId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerImageView.image = headerImage
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.loadData()
    }
    
    func loadData(){
        let request =  MYHttpRequest.base("categories-combinations")
        request.json = [
            "challenge_type": Challenge.typeName
        ]
        request.start() { (success, response) in
            if success {
                self.httpResponse(response)
            }
        }
    }
    
    func httpResponse(_ resultDict: Dictionary<String, Any>) {
        self.dataArray = resultDict.array("combinations")
        tableView.reloadData()
    }
    
    // MARK: table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var dic = self.dataArray[indexPath.row] as! Dictionary<String, Any>
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.textAlignment = NSTextAlignment.center
        
        if Challenge.typeName == ChallengeType.Rall.rawValue {
            dic = dic.dictionary("RallyRank")
            cell.textLabel!.text = dic.string("name")
        }
        else {
            cell.textLabel!.text = dic.string("title")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let ctrl = ResultsDettCtrl.instanceFromSb(self.storyboard)
        ctrl.dicData = self.dataArray[indexPath.row] as! Dictionary<String, Any>
        ctrl.competitionId = self.competitionId
        self.navigationController?.show(ctrl, sender: self)

    }
}
