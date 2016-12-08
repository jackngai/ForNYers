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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blocksWalkedTextField.text = "0"
        avesWalkedTextField.text = "0"
        
        blocksWalkedTextField.addTarget(self, action: #selector(calculateSteps), for: UIControlEvents.editingChanged)
        avesWalkedTextField.addTarget(self, action: #selector(calculateSteps), for: UIControlEvents.editingChanged)
        
        blocksWalkedTextField.delegate = self
        avesWalkedTextField.delegate = self
        
    }

    func calculateSteps() {
        
        guard let blocksWalkedString = blocksWalkedTextField.text,
            let blocksWalked = Double(blocksWalkedString),
            let avesWalkedString = avesWalkedTextField.text,
            let avesWalked = Double(avesWalkedString) else {
                return
        }
        
        totalStepsCalculated.text = String(Int(((blocksWalked * 264.0) + (avesWalked * 900.0))/2.35))

    }


}

extension StepsViewController:UITextFieldDelegate{
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        totalStepsCalculated.text = ""
        return true
    }
}
