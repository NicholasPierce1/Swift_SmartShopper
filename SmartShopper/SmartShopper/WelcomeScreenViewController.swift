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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    @IBAction func SearchAgain(_ sender: Any){
        // before next line, proceed with other setup between both UIViewcontrollers
        self.dismiss(animated: true){
            
            // dismiss handler- render button invisible and have all labels appear
            
        }
    }

}

