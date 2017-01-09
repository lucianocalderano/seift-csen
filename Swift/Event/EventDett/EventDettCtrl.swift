//
//  EventDettCtrl.m
//  CSEN Cinofilia
//
//  Created by Luciano Calderano on 13/01/15.
//  Copyright (c) 2015 Kanito. All rights reserved.
//

import UIKit

class EventDettCtrl: MyViewController {
    var dicData = [String: Any]()
    @IBOutlet private var btnSign: UIButton!
    @IBOutlet private var scroll: UIScrollView!
    
    var eventDettSubview: EventDettSubview?
    
    class func instanceFromSb (_ sb: UIStoryboard!) -> EventDettCtrl {
        return sb.instantiateViewController(withIdentifier: "EventDettCtrl") as! EventDettCtrl
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.headerTitle = self.dicData.string("title")
        
        self.eventDettSubview = (self.storyboard?.instantiateViewController(withIdentifier: "EventDettSubview") as! EventDettSubview)
        self.scroll.addSubview(self.eventDettSubview!.view)
        self.eventDettSubview!.update(self.dicData)
        
        self.loadEventId(self.dicData.string("id"))
        btnSign.isHidden = UserClass().userType == UserType.Club
    }
    
    override func viewDidLayoutSubviews() {
        scroll.contentSize = eventDettSubview!.view.frame.size
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventDettSubview!.view.frame = scroll.frame
        self.checkUserType()
    }
    
    func loadEventId(_ strId: String) {
        let size = UIScreen.main.bounds.size
        let request =  MYHttpRequest.base("event-details")
        request.json = [
            "event_id"  : strId,
            "img_width" : size.width,
            "img_height": size.height,
            "img_crop"  : 2,
            "img_bg"    : "FFFFFF"
        ]
        request.start() { (success, response) in
            if success {
                self.httpResponse(response)
            }
        }
    }
    
    func httpResponse(_ resultDict: Dictionary<String, Any>) {
        self.eventDettSubview!.update(resultDict.dictionary("event.Frontevent"))
        
        if btnSign.isHidden == true {
            return
        }
        btnSign.isEnabled = false
        let d = Date()
        
        let dIni = self.dicData.string("subscription_start").toDateFmt(DateFormat.fmtDb)
        var result:ComparisonResult?
        result = d.compare(dIni)
        if (result == ComparisonResult.orderedAscending) {
            return
        }
        
        let dFin = self.dicData.string("subscription_end").toDateFmt(DateFormat.fmtDb)
        result = d.compare(dFin)
        if (result == ComparisonResult.orderedDescending) {
            return
        }
        btnSign.isEnabled = true
    }
    
    func checkUserType() {
        btnSign.tag = 0
        let s = self.dicData.string("subscription_state")
        if s.isEmpty {
            if UserClass().userType == UserType.Athl {
                btnSign.setTitle(Lng("subscribe"), for: UIControlState())
                btnSign.backgroundColor = UIColor.myGreen()
            }
            else {
                btnSign.setTitle(Lng("subsMustLoginBefore"), for: UIControlState())
                btnSign.tag = 99
            }
        }
        else {
            btnSign.setTitle(Lng("unsubscribe"), for: UIControlState())
            btnSign.backgroundColor = UIColor.myRed()
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        btnSign.alpha = 0.7
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        btnSign.alpha = 1
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        btnSign.alpha = 0.7
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        btnSign.alpha = 1
    }
    
    @IBAction func btnSign(_ sender: UIButton) {
        if btnSign.tag == 99 {
            let sb = UIStoryboard (name: "User", bundle: nil)
            let ctrl = sb.instantiateInitialViewController()
            self.navigationController?.show(ctrl!, sender: self)
        }
        else {
            let ctrl = EventSubsCtrl.instanceFromSb(self.storyboard)
            ctrl.eventId = self.dicData.int("id")
            self.navigationController?.show(ctrl, sender: self)
        }
    }
}
