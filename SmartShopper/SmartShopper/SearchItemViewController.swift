//
//  SecondViewController.swift
//  SmartShopper
//
//  Created by Nick Pierce on 2/24/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class SearchItemViewController: UIViewController {

    @IBOutlet weak var departmentList: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        depList()
    }
    
    
    func depList() {
        let activity_list = UIPickerView()
        activity_list.delegate = self
        departmentList.inputView = activity_list
    }
    
    
    
}


extension SearchItemViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        departmentList.text = Store.shared.returnDepartmentName(for: Store.shared.returnDepartments()[row])
    }
    
}
