//
//  TipCalcViewController.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/23/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//


import UIKit
import Money

class TipCalcViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tipPercentage: UISegmentedControl!
    @IBOutlet weak var numberOfPersons: UISegmentedControl!
    @IBOutlet weak var perPersonTotal: UILabel!
    
    
    // MARK: Properties
    var money:Money = 0
    var currentTip:Double = 0.0
    
    let preferences = UserDefaults.standard
    
    // MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call Calculate whenever user types a number, change tip percentage, or change # of persons
        // Learned from: http://stackoverflow.com/questions/28394933/how-do-i-check-when-a-uitextfield-changes
        // and: http://stackoverflow.com/questions/30545198/swift-handle-action-on-segmented-control
        billAmount.addTarget(self, action: #selector(calculate), for: UIControlEvents.editingChanged)
        tipPercentage.addTarget(self, action: #selector(calculate), for: UIControlEvents.allEvents)
        numberOfPersons.addTarget(self, action: #selector(calculate), for: UIControlEvents.allEvents)
        
        // Add delegate for billAmount textfield
        billAmount.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tipPercentage.selectedSegmentIndex = preferences.integer(forKey: "Default Tip")
        changeTip()
    }

    // MARK: Actions
    @IBAction func singleTap(_ sender: UITapGestureRecognizer) {
        billAmount.resignFirstResponder()
    }
    
    
    @IBAction func changeTipAmount(_ sender: UISegmentedControl) {
        changeTip()
    }
    
    // MARK: Methods
    func changeTip(){
        switch tipPercentage.selectedSegmentIndex{
        case 0:
            currentTip = 10.0
        case 1:
            currentTip = 15.0
        case 2:
            currentTip = 17.75
        case 3:
            currentTip = 18.0
        case 4:
            currentTip = 20.0
        case 5:
            currentTip = 25.0
        case 6:
            currentTip = 30.0
        default:
            currentTip = 0.0
        }
    }
    
    func calculate() {
        print(billAmount.text!)

        // TODO: Look into using money.decimal to refactor and eliminate the 
        // need to use replacingOccurences 3x
        
        billAmount.text = billAmount.text?.replacingOccurrences(of: "$", with: "")
        billAmount.text = billAmount.text?.replacingOccurrences(of: ".", with: "")
        billAmount.text = billAmount.text?.replacingOccurrences(of: ",", with: "")
        
        // MARK: Debug code
        print(billAmount.text!)
        // end Debug code
        
        guard let intBillAmount = Int(billAmount.text!) else {
            print("Invalid Bill Amount")
            return
        }
        
        money = Money(minorUnits: intBillAmount)
        print("money in decimal: \(money.decimal)")
        billAmount.text = String(describing: money)
        
        let tip = (money * currentTip) / 100
        tipAmount.text = String(describing: tip)
        tipAmount.isHidden = false
        
        let total = money + tip
        totalAmount.text = String(describing: total)
        totalAmount.isHidden = false
        
        if numberOfPersons.selectedSegmentIndex >= 0{
            let personTotal = total / (numberOfPersons.selectedSegmentIndex + 2)
            perPersonTotal.text = String(describing: personTotal)
            perPersonTotal.isHidden = false
            
        }
    }
}

extension TipCalcViewController: UITextFieldDelegate {
    
    // Clear tip amount, total amount, and per person total labels and de-select number of persons segmented control
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        tipAmount.text = ""
        totalAmount.text = ""
        perPersonTotal.text = ""
        numberOfPersons.selectedSegmentIndex = -1
        return true
    }
}
