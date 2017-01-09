//
//  UserCtrl
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

class UserLoginCtrl: MyViewController {
    @IBOutlet private var txtUser: UITextField!
    @IBOutlet private var txtPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Footer

        #if (arch(i386) || arch(x86_64)) && os(iOS)
            txtUser.text = "jollysa87asso" // asd
//            txtUser.text = "jollysa87"     // atleta
            txtPass.text = "qwerty"
            //   txtUser.text = @"TOVE"
            //   txtPass.text = @"DUST2003"
        #endif

    }

    @IBAction func btnLogin() {
        if txtUser.text!.isEmpty {
            txtUser.becomeFirstResponder()
            return
        }
        if txtPass.text!.isEmpty {
            txtPass.becomeFirstResponder()
            return
        }
        
        let request =  MYHttpRequest.base("login")
        request.json = [
            "username": txtUser.text!,
            "password": txtPass.text!,
        ]
        request.start() { (success, response) in
            if success {
                self.httpResponse(response)
            }
            else {
                self.showError("Server error")
            }
        }
    }
    
    func httpResponse(_ resultDict: Dictionary<String, Any>) {
        if resultDict.int("status") == 0 {
            self.showError(resultDict.string("error_msg"))
        }
        else {
            let dicUser = resultDict.dictionary("user")
            if dicUser.count == 0 {
                self.showError("Server error (null user)")
            }
            else {
                UserClass().saveUser(dicUser, name: txtUser.text! as String, pass: txtPass.text!)
                let ctrl = UserProfileCtrl.instanceFromSb(self.storyboard)
                self.navigationController?.show(ctrl, sender: self)
            }
        }
    }
    
    func showError(_ errorDesc: String) {
        self.showAlert(errorDesc as String, message: "", okBlock: nil)
    }
}

