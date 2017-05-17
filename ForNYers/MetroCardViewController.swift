//
//  MetroCardViewController.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/23/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//


import UIKit
import Money

class MetroCardViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var currentValueTextField: UITextField!
    @IBOutlet weak var finalValueTextField: UITextField!
    @IBOutlet weak var costField: UILabel!
    @IBOutlet weak var savingsField: UILabel!
    @IBOutlet weak var bonusLabel: UILabel!
    
    
    // MARK: View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        currentValueTextField.delegate = self
        finalValueTextField.delegate = self
        
        currentValueTextField.addTarget(self, action: #selector(calculate), for: UIControlEvents.editingChanged)
        finalValueTextField.addTarget(self, action: #selector(calculate), for: UIControlEvents.editingChanged)
        
    }

    // MARK: Actions
    @IBAction func singleTap(_ sender: UITapGestureRecognizer) {
        currentValueTextField.resignFirstResponder()
        finalValueTextField.resignFirstResponder()
    }
    
    // MARK: Methods
    func calculate() {
        
        guard let finalValueString = finalValueTextField.text, let finalValueDouble = Double(finalValueString) else {
            print("Invalid Final Value")
            return
        }
        
    
        
        let finalValue = Money(finalValueDouble)
        
        var currentValue:Money = 0.0
        
        if currentValueTextField.text != nil || currentValueTextField.text != "" {
            if let currentValueString = currentValueTextField.text{
                if let currentValueDouble = Double(currentValueString){
                    currentValue = Money(currentValueDouble)
                }
            }
        }
        
        let calculatedValue = finalValue - currentValue
        
        guard calculatedValue > 0 else {
            print("Final Value less than current Value.")
            return
        }
        
        if calculatedValue < 5.50 {
            bonusLabel.isHidden = false
            costField.text = String(describing: calculatedValue)
            savingsField.text = "$0.00"
        } else {
            bonusLabel.isHidden = true
            costField.text = String(describing: calculatedValue * 0.95)
            savingsField.text = String(describing: calculatedValue * 0.05)
        }
    }
    
}

extension MetroCardViewController:UITextFieldDelegate{
    
    // Clear the cost and saving labels and hide the warning label when user clears a text field 
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        costField.text = ""
        savingsField.text = ""
        bonusLabel.isHidden = true
        return true
    }
}
