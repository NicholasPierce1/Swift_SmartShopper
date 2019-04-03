//
//  AdminCreateAccountViewController.swift
//  SmartShopper
//
//  Created by Nick Pierce on 2/24/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class AdminCreateAccountViewController: UIViewController {
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var cpassTF: UITextField!
    @IBOutlet weak var storePasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func display(title:String, msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // what happens when back button is invoked? hint: think of how we can go back in modal viewController
    
    
    @IBAction func signupBtn(_ sender: Any?) {
        // forStore takes in the store number... you are passing in the store password
        // once the admin sign up, you should segue back to login screen
        
        if let userName = userNameTF.text, let password = passwordTF.text, let cpass = cpassTF.text, let sPassword = Int(storePasswordTF.text!) {
            if password == cpass {
                let admin =  Store.shared.addAdmin(withUsername: userName, adminPassword: password, forStore: sPassword, storePassword: sPassword)
                print(admin)
                if admin ==  ReturnCode.adminAdded {
                    self.display(title: "Admin Created", msg: "Go back to login screen")
                } else if admin == ReturnCode.adminAlreadyExist {
                    self.display(title: "Admin Already Exists", msg: "Please try diffrent credentials")
                } else {
                    self.display(title: "Error", msg: "Please try diffrent credentials")
                }
            } else {
                self.display(title: "Password doesn't match", msg: "Please try diffrent credentials")
            }
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
