//
//  ChallengeClass.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 08/11/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

struct Challenge {
    static var key = "challenge"
    static var typeName = ""
    static var title = ""
    static var color = UIColor.myBlue()
}

enum ChallengeType: String {
    case None = ""
    case Agil = "agility_dog"
    case Rall = "rally_obedience"
    case Cros = "canicross"
}

class ChallengeClass: NSObject {
    var _type : ChallengeType = ChallengeType.None
    var type: ChallengeType {
        set {
            self.setChallengeClass(newValue)
            self._type = newValue
        }
        get {
            return self._type
        }
    }
    
    private func setChallengeClass (_ type: ChallengeType) {
        Challenge.typeName = type.rawValue
        Challenge.title = self.getTitolo(type.rawValue)
        Challenge.color = self.getColorForType(type.rawValue)
    }
    
    func getTitolo (_ type: String) -> String {
        switch type {
        case ChallengeType.Agil.rawValue:
            return Lng("run01")
        case ChallengeType.Rall.rawValue:
            return Lng("run02")
        case ChallengeType.Cros.rawValue:
            return Lng("run03")
        default:
            return Lng("run00")
        }
    }
    func getColorForType (_ type: String) -> UIColor {
        switch type {
        case ChallengeType.Agil.rawValue:
            return UIColor.myGreen()
        case ChallengeType.Rall.rawValue:
            return UIColor.myRed()
        case ChallengeType.Cros.rawValue:
            return UIColor.myOrange()
        default:
            return UIColor.myBlue()
        }
    }
    func setChallengeClassWithType(_ type: String) {
        switch type {
        case ChallengeType.Agil.rawValue:
            self.setChallengeClass(ChallengeType.Agil)
        case ChallengeType.Rall.rawValue:
            self.setChallengeClass(ChallengeType.Rall)
        case ChallengeType.Cros.rawValue:
            self.setChallengeClass(ChallengeType.Cros)
        default:
            self.setChallengeClass(ChallengeType.None)
        }
    }
    
    
}
