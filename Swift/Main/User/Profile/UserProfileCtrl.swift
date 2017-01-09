//
//  UserProfileCtrl
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

class UserProfileCtrl: MyViewController {
    class func instanceFromSb (_ sb: UIStoryboard!) -> UserProfileCtrl {
        return sb.instantiateViewController(withIdentifier: "UserProfileCtrl") as! UserProfileCtrl
    }

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var mySubsButton: UIButton!
    private var userDict = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Footer

        let dict = UserClass().getUserProfile()
        
        switch UserClass().userType {
        case UserType.Athl:
            let temp = dict.dictionary("Athlete")
            self.dataArray = [
                [ "#UsrDesNom", temp.string("first_name") + " " +  temp.string("last_name") ],
                [ "#UsrDesInd", temp.string("address") ],
                [ "#UsrDesLoc", temp.string("city_name")],
                [ "#UsrDesEml", dict.string("Account.email") ],
                [ "" , ""],
                [ "#UsrDesCoF", temp.string("ssn") ],
                [ "#UsrDesDat", temp.string("birthday") ],
                [ "#UsrDesSex", temp.string("gender") ],
            ]
        case UserType.Club:
            let temp = dict.dictionary("Sportassociation")
            self.dataArray = [
                [ "#UsrDesNom", temp.string("business_name") ],
                [ "#UsrDesInd", temp.string("address") ],
                [ "#UsrDesLoc", temp.string("city_name")],
                [ "#UsrDesTel", temp.string("phone") ],
                [ "#UsrDesEml", dict.string("Account.email") ],
                [ "" , ""],
                [ "#UsrDesWeb", temp.string("website") ],
                [ "#UsrDesFac", temp.string("facebook_account") ],
                [ "#UsrDesTwi", temp.string("twitter_account") ],
                ]
            mySubsButton.isHidden = true
        default:
            mySubsButton.isHidden = true
        }
    }
    
    // MARK: table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = UserProfileCell.dequeue(tableView, indexPath: indexPath)
        let array = self.dataArray[indexPath.row] as! [String]
        
        cell.title.title = array[0]
        cell.descr.text = array[1]
        return cell
    }
    
    // MARK: actions
    
    override func myHeaderBackButtonTapped() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func myHeaderOptionButtonTapped() {
        self.showAlert("Logout ?", message: "", cancelBlock: nil, okBlock: {
            (UIAlertAction) -> Void in
            UserClass().logout()
            _ = self.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    @IBAction private func mySubsButtonTapped()  {
        let ctrl = UserSubscriptionCtrl.instanceFromSb(self.storyboard)
        self.navigationController?.show(ctrl, sender: self)
    }
}
