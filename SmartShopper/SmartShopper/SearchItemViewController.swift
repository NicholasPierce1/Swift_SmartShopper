//
//  SecondViewController.swift
//  SmartShopper
//
//  Created by Nick Pierce on 2/24/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class SearchItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // appends an observer
        NotificationCenter.default.addObserver(self, selector: #selector(checkResults), name: Notification.Name.searchComplete, object: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Store.shared.returnDepartments().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Store.shared.returnDepartmentName(for: Store.shared.returnDepartments()[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         //Store.shared.returnDepartmentName(for: Store.shared.returnDepartments()[row])
    }
    
    @IBAction func search(_ sender: Any?) {
        // call Store.shared.search(passStuffHere)
    }
    
    // observer method that's triggered
    @objc func checkResults(_ notifcation: Notification) {
        
        // force unwrap of hashMap in userInfo
        let passedInfo = notifcation.userInfo as! [String: [Int]]  // array will contain either [1,2,...] or it will be []
        
        if passedInfo["results"]!.count != 0 {
            // call segue with performSegue(withIdentifier: UIStoryBoardSegue, sender: Any?) {} and pass WelcomeScreenVC w/ array

        }
        // empty array--- bad search
        
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        // if called, then pass WelcomeVC the array
    }
}
