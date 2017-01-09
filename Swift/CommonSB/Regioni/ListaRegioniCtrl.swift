//
//  ListaRegioniCtrl.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

protocol ListaRegioniCtrlDelegate: class {
    func didSelectedRegion(_ sender: ListaRegioniCtrl, regionId: String, regionName: String)
}

class ListaRegioniCtrl: MyViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!

    weak var delegate:ListaRegioniCtrlDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        self.loadData()
    }
    
    func loadData(){
        let request =  MYHttpRequest.base("list-regions")
        request.json = [ : ]
        request.start() { (success, response) in
            if success {
                self.httpResponse(response)
            }
        }
    }
    
    func httpResponse(_ resultDict: Dictionary<String, Any>) {
        let dic = [ "Region" : [ "id": "", "name": Lng("AllRegions") ] ]
        self.dataArray = Array([[dic], resultDict.array("regions")].joined())
        tableView.reloadData()
    }
    
    // MARK: table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        let dic = dataArray[indexPath.row] as! Dictionary<String, Any>
        cell.textLabel!.text = dic.string("Region.name")
        cell.textLabel!.textAlignment = NSTextAlignment.center
        cell.textLabel!.font = UIFont.mySizeBold(20)
        cell.textLabel!.textColor = UIColor.myBlue()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (delegate != nil) {
            let dic = dataArray[indexPath.row] as! Dictionary<String, Any>
            delegate?.didSelectedRegion(self, regionId: dic.string("Region.id"), regionName: dic.string("Region.name"))
        }
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
