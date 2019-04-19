//
//  SecondViewController.swift
//  SmartShopper
//
//  Created by Nick Pierce on 2/24/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class SearchItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var vendorTXT: UITextField!
    @IBOutlet weak var itemTXT: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    // holds instance reference to acquired results
    private var results: [Int]?
    
    private var selectedDept:Department!
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectedDept = Store.shared.returnDepartments()[row]
    }
    
    @IBAction func search(_ sender: Any?) {
        // call Store.shared.search(passStuffHere)
        if (selectedDept == nil) {
            let alert = UIAlertController(title: "Error: Selected department not found",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
        Store.shared.search(findLocationOf: itemTXT.text!, in: selectedDept)
        }
    }
    
    // observer method that's triggered
    @objc func checkResults(_ notifcation: Notification) {
        
        // force unwrap of hashMap in userInfo
        let passedInfo = notifcation.userInfo as! [String: [Int]]  // array will contain either [1,2,...] or it will be []
        
        if passedInfo["results"]!.count != 0 {
            self.results = passedInfo["results"]!
            performSegue(withIdentifier: "searchDisplay", sender: self)
        }
            else {  // empty array-- either no results or search target not specific enough
                let alert = UIAlertController(title: "Error: Search unsuccessful",
                                              message: "Please check spelling or be more specific",
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default,
                                              handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
    }
        
        
        func prepareForSegue(segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "searchDisplay"{
                let destination = segue.destination as! WelcomeScreenViewController
                destination.resultArray = self.results!
                destination.selectedDepartment = Store.shared.returnDepartmentName(for: selectedDept)
            }
            
        }

}
