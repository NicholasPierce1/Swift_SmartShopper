//
//  AdminLoginViewController.swift
//  SmartShopper
//
//  Created by Nick Pierce on 2/24/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class AdminLoginViewController: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var spassTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {}
    
    func display(title:String, msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signupBtn(_ sender: Any?) {
        self.performSegue(withIdentifier: "createAdmin", sender: self)
    }
    @IBAction func loginBtn(_ sender: Any?) {
        if let userName = userNameTF.text, let password = passwordTF.text, let spass = Int(spassTF.text!) {
            
            
            let login =  Store.shared.login(username: userName, adminPassword: password, storePassword: spass)
            if login {
                self.performSegue(withIdentifier: "login", sender: self)
            } else {
                self.display(title: "Login Failed", msg: "Please check credentials")
            }
        }
    }
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "login" {
//            return  true// Store.shared.
//        }
//
//        return false
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
