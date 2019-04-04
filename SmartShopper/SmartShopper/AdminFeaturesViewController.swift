//
//  AdminFeaturesViewController.swift
//  SmartShopper
//
//  Created by Nick Pierce on 2/24/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class AdminFeaturesViewController: UIViewController {
    
    
    @IBOutlet weak var departmentList: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
depList()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func depList() {
        let activity_list = UIPickerView()
        activity_list.delegate = self
        departmentList.inputView = activity_list
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



extension AdminFeaturesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        //departmentList.text  = functionality[row]
    }
}
