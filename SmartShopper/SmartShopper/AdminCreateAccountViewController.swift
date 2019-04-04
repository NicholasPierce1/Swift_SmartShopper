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
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var storeNumberTF: UITextField!
    @IBOutlet weak var storePasswordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        userNameTF.text = ""
        passwordTF.text = ""
        confirmPasswordTF.text = ""
        storeNumberTF.text = ""
        storePasswordTF.text = ""
    }
    func display(title:String, msg:String, success:Bool) {
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    var action:UIAlertAction
    if success {
    action = UIAlertAction(title: "OK", style: .default, handler: { _ in
    self.dismiss(animated: true, completion: nil)
    })
    } else {
    action = UIAlertAction(title: "OK", style: .default, handler: nil)
    }
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        if let userName = userNameTF.text, let password = passwordTF.text, let confirmPassword = confirmPasswordTF.text, let sNumber = Int(storeNumberTF.text!), let sPassword = Int(storePasswordTF.text!) {
            if password == confirmPassword { // checking for matching password
                let admin =  Store.shared.addAdmin(withUsername: userName, adminPassword: password, forStore: sNumber, storePassword: sPassword)
                print(admin)
                if admin ==  ReturnCode.adminAdded {
                    self.display(title: "Admin Created", msg: "Go back to login screen", success: true)
                } else if admin == ReturnCode.adminAlreadyExist {
                    self.display(title: "Admin Already Exists", msg: "Please try diffrent credentials", success: false)
                } else {
                    self.display(title: "Error", msg: "Please try diffrent credentials" , success: false)
                }
            } else {
                self.display(title: "Password doesn't match", msg: "Please try diffrent credentials" , success: false)
            }
            
        } else {
            self.display(title: "Error", msg: "Please enter all required fields" , success: false)
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
