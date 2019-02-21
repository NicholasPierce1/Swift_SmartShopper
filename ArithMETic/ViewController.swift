//
//  ViewController.swift
//  ArithMETic
//
//  Created by Nick Pierce on 2/11/19.
//  Copyright © 2019 Nick Pierce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // defines Linked Outlets
    //@IBOutlet weak var activityNameTxt: UITextField!
    @IBOutlet weak var activi: UIPickerView!
    
    @IBOutlet weak var weightNumTxt: UITextField!
    
    @IBOutlet weak var timeTxt: UITextField!
    
    @IBOutlet weak var energyLbl: UILabel!
    
    @IBOutlet weak var losePoundLbl: UILabel!
    
    // defines Linked Actions
    
    // invokes methods to procure corresponding attribute fields and displaying them per user input
    @IBAction func calculate(_ sender: Any){
        // invokes static methods to procure commenuserate return values
        //energyLbl.text = String(format: "%.2f",ExerciseCoach.energyConsumed(during: activityNameTxt.text, weight: weightNumTxt.text, time: timeTxt.text))
        
        //losePoundLbl.text = String(format: "%.2f",ExerciseCoach.timeToLose1Pound(during: activityNameTxt.text, weight: weightNumTxt.text))
    }
    
    // clears textfield properties
    @IBAction func clear(_ sender: Any) {
        activityNameTxt.text = "Activity here"
        weightNumTxt.text = "Lbls"
        timeTxt.text = "Minutes"
        energyLbl.text = "0"
        losePoundLbl.text = "0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

// static struct to calculate energyConsumed and timeToLose1Pound
struct ExerciseCoach{
    
    // dictionary holding the corresponding METs to enumerated activities
    static let metTable:[String: Double] = [
        "Biciycling": 8.0,
    "Jumping rope": 12.3,
    "Running- slow": 9.8,
    "Running- fast": 23,
    "Tennis": Double("8.0")!,
    "Swimming": 5.8
    ]
    
    // taking in the activity, weight, and time of activity to return energyConsumed
    static func energyConsumed(during: String?, weight: String?, time: String?) -> Double{
        // extract METs from during param
        let met = metTable[during!]! // postulating that activity key is valid
        
        // returns the aggregate energyConsumed
        return ((met * 3.5) * (Double(weight!)!/2.2)) / (200 / Double(time!)!)
    }
    
    static func timeToLose1Pound(during: String?, weight: String?) -> Double {
        // extracts METs from metTable per activity param
        let met = metTable[during!]! // postulating that activity is always valid
        
        // returns
        return 3500.0 / ((met * 3.5) * (Double(weight!)!/2.2) / (200))
    }
}
