//
//  NewsCtrl
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit
class NewsCtrl: MyViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var txtSrch: UITextField!
    
    private var numPage = 1
    private var maxRecords = 25
    private var lastPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSrch!.placeholder = Lng("srch")
        self.loadData()
    }
    
    private func loadData(){
        let request =  MYHttpRequest.base("articles")
        request.json = [
            "page"       : numPage,
            "maxrecords" : maxRecords,
            "src"        : txtSrch.text!,
            "img_width"  : 256,
            "img_height" : 256,
            "img_crop"   : 2,
            "img_bg"     : "FFFFFF",
        ]
        
        request.start() { (success, response) in
            if success {
                self.httpResponse(response)
            }
        }
    }
    
    private func httpResponse(_ resultDict: Dictionary<String, Any>) {
        let arr = resultDict.array("articles")
        
        lastPage = (arr.count < maxRecords) ? true : false
        if (numPage == 1) {
            self.dataArray = []
        }
        self.dataArray += arr
        self.tableView.reloadData()
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
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsCell.dequeue(tableView, indexPath: indexPath)
        cell.dicData = self.dataArray[indexPath.row] as! Dictionary<String, Any>
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dict = self.dataArray[indexPath.row] as! Dictionary<String, Any>
        let ctrl = NewsDettCtrl.instanceFromSb(self.storyboard)
        ctrl.idNews = dict.string("Frontarticle.id")
        self.navigationController?.show(ctrl, sender: self)
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
}

