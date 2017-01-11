//
//  UserClass.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 02/11/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import Foundation

enum UserType: String {
    case None = ""
    case Athl = "athlete"
    case Club = "sport_association"
}

class UserClass: NSObject {
    static let sharedInstance = UserClass()

    var userType:UserType {
        set {
            self.userType = newValue
        }
        get {
            return self.getUserType()
        }
    }
    
    private let keyName = "keyName"
    private let keyPass = "keyPass"
    private let keyProf = "keyProf"
    
    private func getUserType() -> UserType {
        let dict = self.getUserProfile()
        if dict.count == 0 {
            return UserType.None
        }
        switch dict.string("Account.type") {
        case UserType.Athl.rawValue:
            return UserType.Athl
        case UserType.Club.rawValue:
            return UserType.Club
        default:
            break
        }
        return UserType.None
    }
    
    func getUserProfile() -> Dictionary<String, Any> {
        let user = UserDefaults.standard.object(forKey: keyProf)
        guard user != nil else {
            return [:]
        }
        return user as! Dictionary
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: keyProf)
        UserDefaults.standard.synchronize()
    }
    
    func saveUser(_ dict:Dictionary<String, Any>, name:String, pass:String) {
        UserDefaults.standard.setValue(name, forKey: keyName)
        UserDefaults.standard.setValue(pass, forKey: keyPass)
        UserDefaults.standard.setValue(dict, forKey: keyProf)
        UserDefaults.standard.synchronize()
    }
    
    func getAccountId () -> Int {
        return self.getUserProfile().int("Account.id")
    }
}

////
////  UserClass.swift
////  CsenCinofilia
////
////  Created by Luciano Calderano on 02/11/16.
////  Copyright © 2016 Kanito. All rights reserved.
////
//
//import Foundation
//
//enum UserType: String {
//    case None = ""
//    case Athl = "athlete"
//    case Club = "sport_association"
//}
//
//class UserClass: NSObject {
//    var userType:UserType {
//        set {
//            self.userType = newValue
//        }
//        get {
//            return self.getUserType()
//        }
//    }
//    
//    private let keyName = "keyName"
//    private let keyPass = "keyPass"
//    private let keyProf = "keyProf"
//    
//    private func getUserType() -> UserType {
//        let dict = self.getUserProfile()
//        if dict.count == 0 {
//            return UserType.None
//        }
//        switch dict.string("Account.type") {
//        case UserType.Athl.rawValue:
//            return UserType.Athl
//        case UserType.Club.rawValue:
//            return UserType.Club
//        default:
//            break
//        }
//        return UserType.None
//    }
//    
//    func getUserProfile() -> Dictionary<String, Any> {
//        let user = UserDefaults.standard.object(forKey: keyProf)
//        guard user != nil else {
//            return [:]
//        }
//        return user as! Dictionary
//    }
//    
//    func logout() {
//        UserDefaults.standard.removeObject(forKey: keyProf)
//        UserDefaults.standard.synchronize()
//    }
//    
//    func saveUser(_ dict:Dictionary<String, Any>, name:String, pass:String) {
//        UserDefaults.standard.setValue(name, forKey: keyName)
//        UserDefaults.standard.setValue(dict, forKey: keyProf)
//        UserDefaults.standard.synchronize()
//        
//        let keyChain = Keychain(service: "CsenCinofilia",
//                                account: name,
//                                userGrp: "kanito.it")
//        do {
//        try keyChain.savePassword(pass)
//        }
//        catch {
//            fatalError("Error updating keychain - \(error)")
//        }
//    }
//}
