//
//  StepsViewController.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/23/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController {

    @IBOutlet weak var blocksWalkedTextField: UITextField!
    @IBOutlet weak var avesWalkedTextField: UITextField!
    @IBOutlet weak var totalStepsCalculated: UILabel!
    
//    var blocksWalked = 0
//    var avesWalked = 0
//    var totalSteps = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func calculateSteps(_ sender: UIButton) {
        
        guard let blocksWalkedString = blocksWalkedTextField.text,
            let blocksWalked = Double(blocksWalkedString),
            let avesWalkedString = avesWalkedTextField.text,
            let avesWalked = Double(avesWalkedString) else {
                print("Invalid entry in blocksWalked/avesWalked fields")
                return
        }
        
        totalStepsCalculated.text = String(Int(((blocksWalked * 264.0) + (avesWalked * 900.0))/2.35))
        
        
    }


}
