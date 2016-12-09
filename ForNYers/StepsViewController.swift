//
//  StepsViewController.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/23/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController {

    // MARK: Oulets
    @IBOutlet weak var blocksWalkedTextField: UITextField!
    @IBOutlet weak var avesWalkedTextField: UITextField!
    @IBOutlet weak var totalStepsCalculated: UILabel!
    
    // MARK: Properties
    var strideLength = 2.4
    
    // MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        blocksWalkedTextField.addTarget(self, action: #selector(calculateSteps), for: UIControlEvents.editingChanged)
        avesWalkedTextField.addTarget(self, action: #selector(calculateSteps), for: UIControlEvents.editingChanged)
        
        blocksWalkedTextField.delegate = self
        avesWalkedTextField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: Debug code
        print("stride length from settings: \(UserDefaults.standard.double(forKey: "Stride Length"))")
        // End Debug code
        
        if UserDefaults.standard.double(forKey: "Stride Length") != 0.0 {
            strideLength = UserDefaults.standard.double(forKey: "Stride Length")
        }
        
    }
    
    // MARK: Actions
    
    // Hide keyboard when user taps anywhere else on the screen
    @IBAction func singleTap(_ sender: UITapGestureRecognizer) {
        blocksWalkedTextField.resignFirstResponder()
        avesWalkedTextField.resignFirstResponder()
    }
    
    // MARK: Methods
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
    // Clear the total steps label when user clears any text field
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        totalStepsCalculated.text = ""
        return true
    }
}
