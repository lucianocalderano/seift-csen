//
//  ListaRegioniCtrl.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

protocol AreaCtrlDelegate: class {
    func didSelectedArea(_ sender: AreaCtrl, selectedAreaId: String)
}


class AreaCtrl: MyViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!
    private var areaDict = [String: Any]()
    
    weak var delegate:AreaCtrlDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        self.loadData()
    }
    
    func loadData(){
        let request =  MYHttpRequest.base("list-areas")
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
        self.areaDict = resultDict.dictionary("areas") 
        self.dataArray = Array(self.areaDict.keys.sorted())
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
        let key = self.dataArray[indexPath.row] as? String
        cell.textLabel!.text = self.areaDict.string(key!)
        cell.textLabel!.textAlignment = NSTextAlignment.center
        cell.textLabel!.font = UIFont.mySizeBold(20)
        cell.textLabel!.textColor = UIColor.myBlue()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (delegate != nil) {
            delegate?.didSelectedArea(self, selectedAreaId: self.dataArray[indexPath.row] as! String)
        }
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
