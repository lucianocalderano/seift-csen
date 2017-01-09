//
//  UserCtrl
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

enum NextSb: String {
    case user = "User"
    case news = "News"
    case evnt = "Event"
    case resu = "Results"
    case rank = "Rank"
    case binm = "Binomi"
    case club = "Club"
}

class MainCtrl : UIViewController, EventTypeCtrlDelegate {
    private var strStor:String = ""
    private var strCtrl:String = ""

    @IBOutlet private var btnNews: UIButton!
    @IBOutlet private var btnRuns: UIButton!
    @IBOutlet private var btnResu: UIButton!
    @IBOutlet private var btnStat: UIButton!
    @IBOutlet private var btnClub: UIButton!
    @IBOutlet private var btnBinm: UIButton!
    @IBOutlet private var btnUser: MYButtonRounded!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WheelConfig.backWheelImage = UIImage.init(named: "logo")

        self.navigationController!.view.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white
    }

    @IBAction func btnClick (_ sender: UIButton) {
        var selectEventType = false
        var showAllEventTypes = true
        
        strStor = ""
        strCtrl = ""
        
        switch (sender) {
        case btnUser:
            strStor = NextSb.user.rawValue
            strCtrl = UserClass().userType == UserType.None ? "" : "UserProfileCtrl"
        case btnNews:
            strStor = NextSb.news.rawValue
        case btnRuns:
            selectEventType = true
            strStor = NextSb.evnt.rawValue
        case btnResu:
            selectEventType = true
            strStor = NextSb.resu.rawValue
        case btnStat:
            selectEventType = true
            showAllEventTypes = false
            strStor = NextSb.rank.rawValue
        case btnBinm:
            strStor = NextSb.binm.rawValue
        case btnClub:
            strStor = NextSb.club.rawValue
        default:
            return
        }
        if (selectEventType == false) {
            self.gotoNextViewCtrl()
        }
        else {
            self.selectRunType(showAllEventTypes)
        }
    }
    
    private func gotoNextViewCtrl () {
        let sb = UIStoryboard (name: strStor, bundle: nil)
        let ctrl = (strCtrl.isEmpty) ? sb.instantiateInitialViewController() :
                                       sb.instantiateViewController(withIdentifier: strCtrl)
        self.navigationController?.show(ctrl!, sender: self)
    }
    
    private func selectRunType (_ type: Bool) {
        let ctrl = EventTypeCtrl()
        ctrl.delegate = self
        ctrl.showAllTypes = type
        self.navigationController?.show(ctrl, sender: self)
    }
    
    internal func didSelectedRunType(_ sender: EventTypeCtrl) {
        self.gotoNextViewCtrl()
    }
}
