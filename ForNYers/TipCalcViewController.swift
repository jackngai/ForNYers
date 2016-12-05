//
//  TipCalcViewController.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/23/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

// TODO: Add segment control to divide by 2 - 9 persons

import UIKit
import Money

class TipCalcViewController: UIViewController {

    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tipPercentage: UISegmentedControl!
    
    
    var money:Money = 0
    var currentTip:Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dUISegmentedControl = UISegmentedControl()
        changeTipAmount(dUISegmentedControl)
        
        print("Tip = \(currentTip)")
        
        // TODO: Load default tip percentage from NSUserDefaults
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func calculate(_ sender: UIButton) {
        print(billAmount.text!)
        
        billAmount.text = billAmount.text?.replacingOccurrences(of: "$", with: "")
        billAmount.text = billAmount.text?.replacingOccurrences(of: ".", with: "")
        billAmount.text = billAmount.text?.replacingOccurrences(of: ",", with: "")

        print(billAmount.text!)
        
        guard let intBillAmount = Int(billAmount.text!) else {
            print("Invalid Bill Amount")
            return
        }
        
        money = Money(minorUnits: intBillAmount)
        billAmount.text = String(describing: money)
        
        tipAmount.text = String(describing: (money * currentTip) / 100)
 
        tipAmount.isHidden = false
        
        totalAmount.text = String(describing: money + ((money * currentTip) / 100))
        totalAmount.isHidden = false
    }
    
    @IBAction func changeTipAmount(_ sender: UISegmentedControl) {
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
    

    

    

}
