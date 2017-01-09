//
//  BinomiCtrl.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit
class EventCtrl: MyViewController, UITableViewDelegate, UITableViewDataSource, AreaCtrlDelegate {
    @IBOutlet private var tableView: UITableView!
    
    private var areaId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myHeader.optionButton.isHidden = Challenge.typeName.isEmpty
        self.loadData()
    }
    
    func loadData(){
        let request =  MYHttpRequest.base("list-events")
        request.json = [
            "page"           : 1,
            "maxrecords"     : 50,
            "type"           : Challenge.key,
            "challenge_type" : Challenge.typeName,
            "challenge_area" : self.areaId,
            "img_width"      : UIScreen.main.bounds.size.width - 10,
            "img_height"     : 80,
            "img_crop"       : 1,
            "img_bg"         : "FFFFFF",
        ]
        request.start() { (success, response) in
            if success {
                self.httpResponse(response)
            }
        }
    }
    
    func httpResponse(_ resultDict: Dictionary<String, Any>) {
        self.dataArray = resultDict.array("events")
        tableView.reloadData()
    }
    
    // MARK: table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EventCell.dequeue(tableView, indexPath: indexPath)
        cell.dicData = self.dataArray[indexPath.row] as! Dictionary<String, Any>
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ctrl = EventDettCtrl.instanceFromSb(self.storyboard)
        let dic = self.dataArray[indexPath.row] as! Dictionary<String, Any>
        ctrl.dicData = dic.dictionary("Frontevent")
        self.navigationController?.show(ctrl, sender: self)
    }
    
    // MARK: select area
    
    override func myHeaderOptionButtonTapped() {
        let ctrl = AreaCtrl()
        ctrl.delegate = self
        self.navigationController?.show(ctrl, sender: self)
    }
    
    func didSelectedArea(_ sender: AreaCtrl, selectedAreaId: String) {
        self.areaId = selectedAreaId
        self.loadData()
    }
}
