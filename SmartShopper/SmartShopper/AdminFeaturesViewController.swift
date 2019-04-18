//
//  AdminFeaturesViewController.swift
//  SmartShopper
//
//  Created by Nick Pierce on 2/24/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class AdminFeaturesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var simplifiedPhraseTXT: UITextField!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var changeLanesNewAisleTXT: UITextField!
    @IBOutlet weak var changeLanesBarcodeTXT: UITextField!
    @IBOutlet weak var removeBarcodeTXT: UITextField!
    @IBOutlet weak var removeBarcodeLBL: UILabel!
    @IBOutlet weak var laneBarcodeLBL: UILabel!
    @IBOutlet weak var barcodeLBL: UILabel!
    @IBOutlet weak var newAisleLBL: UILabel!
    @IBOutlet weak var nameTXT: UITextField!
    @IBOutlet weak var simplifiedPhraseLBL: UILabel!
    @IBOutlet weak var vendorTXT: UITextField!
    @IBOutlet weak var departmentLBL: UILabel!
    @IBOutlet weak var barcodeTXT: UITextField!
    @IBOutlet weak var departmentTXT: UITextField!
    @IBOutlet weak var aisleNumTXT: UITextField!
    @IBOutlet weak var departmentList: UITextField!
    @IBOutlet weak var vendorLBL: UILabel!
    @IBOutlet weak var aisleNumLBL: UILabel!
    private var departmentSelected: Department!
    override func viewDidLoad() {
        super.viewDidLoad()
        depList()
        // Do any additional setup after loading the view.
    }
    override func  viewWillAppear(_ animated: Bool) {
        // hide all labels and textfields
        // so... button will only be visible
        changeLanesNewAisleTXT.isHidden = true
        changeLanesBarcodeTXT.isHidden = true
        removeBarcodeTXT.isHidden = true
        aisleNumTXT.isHidden = true
        departmentTXT.isHidden = true
        barcodeTXT.isHidden = true
        vendorTXT.isHidden = true
        nameTXT.isHidden = true
        newAisleLBL.isHidden = true
        laneBarcodeLBL.isHidden = true
        removeBarcodeLBL.isHidden = true
        aisleNumLBL.isHidden = true
        departmentLBL.isHidden = true
        barcodeLBL.isHidden = true
        vendorLBL.isHidden = true
        departmentList.isHidden = true
        nameLBL.isHidden = true
        barcodeLBL.isHidden = true
        simplifiedPhraseTXT.isHidden = true
        simplifiedPhraseLBL.isHidden = true
    }

    @IBAction func addBTN(_ sender: UIButton) {
        /*returnCode = addItem(nameOfItem itemName: String, simplifiedSearchPhrase categoryName: String, vendor: String, barcode: String, toThisDepartment dept: Department, aisleOfItem aisleNum: Int! = nil) -> ReturnCode */
        
        // firsts thing first: unhide (isHidden = false) to all labels and textfields for adding
        // second thing: hide everything else
    
        changeLanesNewAisleTXT.isHidden = true
        changeLanesBarcodeTXT.isHidden = true
        removeBarcodeTXT.isHidden = true
        aisleNumTXT.isHidden = true
        departmentTXT.isHidden = false
        barcodeTXT.isHidden = false
        vendorTXT.isHidden = false
        nameTXT.isHidden = false
        newAisleLBL.isHidden = true
        laneBarcodeLBL.isHidden = true
        removeBarcodeLBL.isHidden = true
        aisleNumLBL.isHidden = false
        departmentLBL.isHidden = false
        barcodeLBL.isHidden = false
        vendorLBL.isHidden = false
        departmentList.isHidden = false
        nameLBL.isHidden = false
        simplifiedPhraseTXT.isHidden = false
        simplifiedPhraseLBL.isHidden = false
        
        // third check if user entered valid data, if dept is multi and that ailse num can be an int if so
        // return
        
        // calls method and checks results
        let result: ReturnCode = Store.shared.addItem(nameOfItem: nameTXT.text!, simplifiedSearchPhrase: simplifiedPhraseTXT.text!, vendor: vendorTXT.text!, barcode: barcodeTXT.text!, toThisDepartment:  departmentSelected, aisleOfItem: Int(aisleNumTXT.text!))  // handles IF dept is NOT multi ailse
        
        if (result == .aisleOutOfRangeForDeparment) {
            let alert = UIAlertController(title: "Item out of range for department",
                message: "",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                            handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (result == .invalidBarcodelength) {
            let alert = UIAlertController(title: "Barcode length invalid",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (result == .duplicateBarcode) {
            let alert = UIAlertController(title: "Duplicate Barcode",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (result == .duplicateItemForVendor) {
            let alert = UIAlertController(title: "",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Item Added Successfully",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
 
    }
    
    @IBAction func removeBTN(_ sender: Any) {
        changeLanesNewAisleTXT.isHidden = true
        changeLanesBarcodeTXT.isHidden = true
        removeBarcodeTXT.isHidden = false
        aisleNumTXT.isHidden = true
        departmentTXT.isHidden = true
        barcodeTXT.isHidden = true
        vendorTXT.isHidden = true
        nameTXT.isHidden = true
        newAisleLBL.isHidden = true
        laneBarcodeLBL.isHidden = true
        removeBarcodeLBL.isHidden = false
        aisleNumLBL.isHidden = true
        departmentLBL.isHidden = true
        barcodeLBL.isHidden = true
        vendorLBL.isHidden = true
        departmentList.isHidden = true
        nameLBL.isHidden = true
        simplifiedPhraseTXT.isHidden = true
        simplifiedPhraseLBL.isHidden = true
        
        let result: ReturnCode = Store.shared.removeItem(remove: removeBarcodeTXT.text!, in: departmentSelected)
        if (result == .invalidBarcodelength) {
            let alert = UIAlertController(title: "Invalid Barcode Length",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (result == .itemNotInStore) {
            let alert = UIAlertController(title: "Item not in store",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Item Removed Successfully",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func changeLanesBTN(_ sender: Any) {
        changeLanesNewAisleTXT.isHidden = false
        changeLanesBarcodeTXT.isHidden = false
        removeBarcodeTXT.isHidden = true
        aisleNumTXT.isHidden = true
        departmentTXT.isHidden = true
        barcodeTXT.isHidden = true
        vendorTXT.isHidden = true
        nameTXT.isHidden = true
        newAisleLBL.isHidden = false
        laneBarcodeLBL.isHidden = false
        removeBarcodeLBL.isHidden = true
        aisleNumLBL.isHidden = true
        departmentLBL.isHidden = true
        barcodeLBL.isHidden = true
        vendorLBL.isHidden = true
        departmentList.isHidden = true
        nameLBL.isHidden = true
        simplifiedPhraseTXT.isHidden = true
        simplifiedPhraseLBL.isHidden = true
        
        let result: ReturnCode = Store.shared.changeAisle(for: changeLanesBarcodeTXT.text!, in: departmentSelected, toThisAisle: Int(changeLanesNewAisleTXT.text!)!)
        if (result == .aisleOutOfRangeForDeparment) {
            let alert = UIAlertController(title: "Aisle out of range for department",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (result == .invalidBarcodelength) {
            let alert = UIAlertController(title: "Invalid Barcode Length",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (result == .itemNotInStore) {
            let alert = UIAlertController(title: "Item is not in store",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Aisle changed Successfully",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func logoutBtn(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "backToWelcome", sender: nil)
    }
    
    func depList() {
        let activity_list = UIPickerView()
        activity_list.delegate = self
        activity_list.dataSource = self
        departmentList.inputView = activity_list
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Store.shared.returnDepartments().count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Store.shared.returnDepartmentName(for: Store.shared.returnDepartments()[row])
    }
    
    // hides ailse number from picker view when adding items
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        departmentList.text = Store.shared.returnDepartmentName(for: Store.shared.returnDepartments()[row])
        if (Store.shared.departmentIsMultiAisle(for: Store.shared.returnDepartments()[row])) {
            aisleNumLBL.isHidden = false
            aisleNumTXT.isHidden = false
        }
            else {
            aisleNumLBL.isHidden = true
            aisleNumTXT.isHidden = true
         }
 
        //departmentList.text = Store.shared.returnDepartmentName(for:(Store.shared.returnDepartments()[row]) )
        departmentSelected = Store.shared.returnDepartments()[row] // holds department
    }
}

