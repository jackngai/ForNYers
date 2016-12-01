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

    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tipPercentage: UISegmentedControl!
    
    
    var money:Money = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //tipPercentage.setWidth(CGFloat(25.0), forSegmentAt: 2)
        
        print(tipPercentage.widthForSegment(at: 0))
        
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
        
        let intBillAmount = Int(billAmount.text!)!
        
        money = Money(minorUnits: intBillAmount)
        billAmount.text = String(describing: money)
        
        tipAmount.text = String(describing: money * 0.15)
        tipAmount.isHidden = false
        
        totalAmount.text = String(describing: money * 1.15)
        totalAmount.isHidden = false
    }

}
