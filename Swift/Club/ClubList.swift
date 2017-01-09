//
//  ClubList.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 26/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit
import MessageUI

class ClubList: MyViewController, UIScrollViewDelegate, ClubListCellDelegate, MFMailComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, ListaRegioniCtrlDelegate {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var txtSrch: UITextField!
    
    var numPage = 1
    var maxRecords = 25
    var lastPage = false

    var strRegionId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData(){
        let request =  MYHttpRequest.base("associations-list")
        request.json = [
            "page"       : numPage,
            "maxrecords" : maxRecords,
            "region_id"  : strRegionId,
            "lang_id"    : Lng("iso"),
            "src"        : txtSrch!.text!,
            "img_width"  : 80,
            "img_height" : 80,
            "img_crop"   : 2,
            "img_bg"     : "FFFFFF",
        ]
        request.start() { (success, response) in
            if success {
                self.httpResponse(response)
            }
        }
    }
    
    func httpResponse(_ resultDict: Dictionary<String, Any>) {
        let arr = resultDict.array("associations")
        
        lastPage = (arr.count < maxRecords) ? true : false
        if (numPage == 1) {
            dataArray.removeAll()
        }
        dataArray += arr
        tableView.reloadData()
    }
    
    // MARK: Search
    
    @IBAction func btnSrch() {
        numPage = 1
        self.loadData()
        txtSrch?.resignFirstResponder()
    }
    
    // MARK: table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ClubListCell.dequeue(tableView, indexPath: indexPath)
        cell.dicData = self.dataArray[indexPath.row] as! Dictionary<String, Any>
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Load next page

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (lastPage == true) {
            return
        }
        let lastRow = (self.tableView.indexPath(for: self.tableView.visibleCells.last!)?.row)! + 1
        if lastRow == self.numPage * self.maxRecords {
            numPage += 1
            self.loadData()
        }
    }

    // MARK: Select region
    
    override func myHeaderOptionButtonTapped() {
        let ctrl = ListaRegioniCtrl ()
        ctrl.delegate = self
        self.navigationController?.show(ctrl, sender: self)
    }
    
    func didSelectedRegion(_ sender: ListaRegioniCtrl, regionId: String, regionName: String) {
        numPage = 1
        strRegionId = regionId
        self.headerTitle = regionName
        self.loadData()
    }
    
    // MARK: delegate phone
    
    func didPhoneTapped(_ sender: ClubListCell, value: String) {
        let s: String = "telprompt://" + value
        UIApplication.shared.openURL(URL(string: s)!)
    }
    
    // MARK: delegate email
    
    func didEmailTapped(_ sender: ClubListCell, value: String) {
        let mailComposeViewController = configuredMailComposeViewController(value)
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
        else {
            self.showSendMailErrorAlert("Could Not Send Email")
        }
    }
    
    func configuredMailComposeViewController(_ dest: String) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([dest])
        mailComposerVC.setSubject("")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if (error != nil) {
            self.showSendMailErrorAlert((error?.localizedDescription)!)
        }
        controller.popViewController(animated: true)
    }
    
    // MARK: Alert

    func showSendMailErrorAlert(_ title: String) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
