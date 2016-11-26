//
//  MetroCardViewController.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/23/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import UIKit

class MetroCardViewController: UIViewController {

    
    @IBOutlet weak var cardValueTextField: UITextField!
    @IBOutlet weak var ridesTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        
        let cardValueString = cardValueTextField.text ?? "0"
        
        guard let cardValue = Double(cardValueString),
            let ridesString = ridesTextField.text,
            let rides = Double(ridesString) else {
                print("Invalid Current Card Value field and/or Number of Rides")
                return
        }
        
        var ridesCost = (2.75 * rides) - cardValue
        
        if ridesCost < 0 {
            //let availableRides = Int(cardValue / 2.75)
            let alertController = UIAlertController(title: "Hmm...", message: "Your card value has enough for the number of rides you need. Did you mean to add that number of rides to the card?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes, please.", style: .default) {
                _ in
                ridesCost = (2.75 * rides)
                self.costTextField.text = String(ridesCost)
            }
            let reEnterAction = UIAlertAction(title: "No, let me re-enter", style: .destructive) {
                _ in
                self.ridesTextField.text = ""
            }
            alertController.addAction(yesAction)
            alertController.addAction(reEnterAction)
            present(alertController, animated: true, completion: nil)
        }
        
        
        if ridesCost >= 5.50 {
            costTextField.text = String(ridesCost * 0.9009)
        } else {
            let alertController = UIAlertController(title: "Warning", message: "You are refilling less than $5.50 and will not get the 11% bonus.", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "I'm aware", style: .destructive) {
                _ in
                self.costTextField.text = String(ridesCost)
            }
            let reEnterAction = UIAlertAction(title: "Let me re-enter", style: .cancel) {
                _ in
                self.ridesTextField.text = ""
            }
            alertController.addAction(continueAction)
            alertController.addAction(reEnterAction)
            present(alertController, animated: true, completion: nil)
        }

    
        
    }



}
 
