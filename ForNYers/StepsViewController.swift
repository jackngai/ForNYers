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
    
    var strideLength = 2.4
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blocksWalkedTextField.addTarget(self, action: #selector(calculateSteps), for: UIControlEvents.editingChanged)
        avesWalkedTextField.addTarget(self, action: #selector(calculateSteps), for: UIControlEvents.editingChanged)
        
        blocksWalkedTextField.delegate = self
        avesWalkedTextField.delegate = self
        
        // MARK: Test code
        print("stride length from settings: \(UserDefaults.standard.double(forKey: "Stride Length"))")
        
        if UserDefaults.standard.double(forKey: "Stride Length") != 0.0 {
            strideLength = UserDefaults.standard.double(forKey: "Stride Length")
        }
        
    }

    func calculateSteps() {
        
        guard let blocksWalkedString = blocksWalkedTextField.text,
            let avesWalkedString = avesWalkedTextField.text else {
                return
        }
        
        let blocksWalked = Double(blocksWalkedString) ?? 0.0
        let avesWalked = Double(avesWalkedString) ?? 0.0
        
        totalStepsCalculated.text = String(Int(((blocksWalked * 264.0) + (avesWalked * 900.0))/strideLength))
        
    }


}

extension StepsViewController:UITextFieldDelegate{
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        totalStepsCalculated.text = ""
        return true
    }
}
