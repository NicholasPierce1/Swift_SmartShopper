//
//  FirstViewController.swift
//  SmartShopper
//
//  Created by Nick Pierce on 2/24/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {

    // retains reference to SearchItemViewController's array from result
    var resultArray: [Int]?
    
    // retains reference to SearchItemViewController's selected Department
    var selectedDepartment: String?
    
    // enumerates overlayed labels to be used to display search result locations
    @IBOutlet weak var dairyDept: UILabel!
    @IBOutlet weak var frozenDept: UILabel!
    @IBOutlet weak var groceryDept: UILabel!
    @IBOutlet weak var floralDept: UILabel!
    @IBOutlet weak var deliDept: UILabel!
    @IBOutlet weak var bakeryDept: UILabel!
    @IBOutlet weak var meatDept: UILabel!
    @IBOutlet weak var seafoodDept: UILabel!
    @IBOutlet weak var seasonalDept: UILabel!
    @IBOutlet weak var healthBeautyDepartment: UILabel!
    @IBOutlet weak var produceDept: UILabel!
    
    // establishes search button (initially hidden)
    @IBOutlet weak var searchButton: UIButton!
    
    // retains all departments
    var deptListing: [String: UILabel?] {  // read only
        return ["Dairy": dairyDept, "Frozen/Dairy": frozenDept, "Grocery": groceryDept, "Floral": floralDept, "Deli": deliDept, "BakeryDept": bakeryDept, "Meat": meatDept, "Seafood": seafoodDept, "Seasonal": seasonalDept, "HBC": healthBeautyDepartment, "Produce": produceDept]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hides search button (initial lode)
        searchButton.isHidden = true
        
    }
/*
    override func loadView() {
        super.loadView()
        
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.lightGray, UIColor.darkGray]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        
        view.layer.addSublayer(layer)
        
    }*/
    
    // dismisses modal segue to permit subsequent search
    @IBAction func SearchAgain(_ sender: Any){
        // before next line, proceed with other setup between both UIViewcontrollers
        self.dismiss(animated: true){
            
            // dismiss handler- render button invisible and have all labels appear
            self.reappearLabels()
        }
    }
    
    // reappears all labels
    func reappearLabels() -> Void{
        
        // for loop to iterate over all departments
        for deptLabel: UILabel? in deptListing.values{
            deptLabel!.isHidden = false  // enjoins label to be visible
        }
    }
    
    // hides all labels that aren't comprised in resultArray
    func displayResults() -> Void {
        
        /* checks if department has multiple aisles (later: then grab label by aisle num-- index position in hash
        for deptName in deptListing.keys.filter(return $0 != selectedDepartment){ for label: UILabel? in deptListing[deptName]! { label?.isHidden=true }}
         if Store.shared.isMultiAsile(deptListing[selectedDepartment]!){
         // hide all ailses in multiAisle dept BUT the one selected- for aisle in deptListing[selectedDepartment]!.count{ if !resultArray.contains(aisle) { deptListing[selectedDepartment]![aisle]?.isHidden = true }}}
         // not multi aisle and all non-match depts have been turned off. Do nothing
        */
        
        // turns all deptlabel that don't match selected department (temp)
        for deptLabel: UILabel? in deptListing.keys.filter({return $0 != selectedDepartment}).map({deptListing[$0]!}){
            deptLabel?.isHidden = true
        }
    }

}

