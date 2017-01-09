//
//  EventTypeCtrl
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

protocol EventTypeCtrlDelegate: class {
    func didSelectedRunType(_ sender: EventTypeCtrl)
}

class EventButton: UIButton {
    var type = ChallengeType.None
}

class EventTypeCtrl: MyViewController {
    @IBOutlet private var btnNone: EventButton!
    @IBOutlet private var btnAgil: EventButton!
    @IBOutlet private var btnRall: EventButton!
    @IBOutlet private var btnCros: EventButton!

    weak var delegate:EventTypeCtrlDelegate?
    var showAllTypes:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
//TODO: Footer
        
        self.button(btnNone, tag: ChallengeType.None)
        self.button(btnAgil, tag: ChallengeType.Agil)
        self.button(btnRall, tag: ChallengeType.Rall)
        self.button(btnCros, tag: ChallengeType.Cros)

        if self.showAllTypes == false {
            btnNone.isHidden = true
        }
    }
    
    private func button(_ btn:EventButton, tag:ChallengeType) {
        btn.tag = tag.hashValue
        btn.type = tag
        btn.layer.cornerRadius = 20.0
        btn.setTitle(btn.titleLabel?.text!.tryLang(), for: UIControlState())
    }

    @IBAction func btnClick (_ sender: EventButton) {
        ChallengeClass().type = sender.type
        if (delegate != nil) {
            delegate?.didSelectedRunType(self)
        }
    }
    
    @IBAction func kanitoTapped () {
        let s = "itms-apps://itunes.apple.com/it/app/kanito/id875758829?mt=8&uo=4"
        UIApplication.shared.openURL(URL.init(string: s)!)
    }

}
