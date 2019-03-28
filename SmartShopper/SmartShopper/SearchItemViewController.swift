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
        
        // clears label
        
        // appends an observer
        NotificationCenter.default.addObserver(self, selector: #selector(checkResults(_ :)), name: Notification.Name.searchComplete, object: nil)
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
            // call segue with performSegue(withIdentifier: UIStoryBoardSegue, sender: Any?) {}
            // pass array and department NAME to WelcomeViewController
            

        }
        // empty array--- bad search
        // raise alertcontroller to display error
        
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        // if called, then pass WelcomeVC the array and selectedDepartment name
        // ALSO: denote the searchButton invisible
    }
    
    
        @IBAction func doSomething(_ sender: Any?){
            DispatchQueue.global(qos: .userInteractive).async{
                // did stuff-- got new content
                DispatchQueue.main.async {
                    // updated labels accordingly
                    // yields a DEADLOCK context switch
                }
            }
            // do other stuff with labels
        }
}
