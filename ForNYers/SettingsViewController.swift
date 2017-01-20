//
//  SettingsViewController.swift
//  ForNYers
//
//  Created by Jack Ngai on 12/8/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var defaultTabPicker: UIPickerView!
    @IBOutlet weak var defaultTipSegmentedControl: UISegmentedControl!
    
    // Learned setting up stepper from: http://sourcefreeze.com/uistepper-example-in-swift/
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var strideLength: UILabel!
    
    // MARK: Properties
    // Learned setting up picker view from: http://codewithchris.com/uipickerview-example/
    var tabPickerData: [String] = []
    
    let preferences = UserDefaults.standard
    
    
    // MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabPickerData = ["News", "Tip Calculator","Metrocard Calculator", "Steps Calculator"]
        
        defaultTabPicker.dataSource = self
        defaultTabPicker.delegate = self
        
        defaultTabPicker.selectRow(preferences.integer(forKey: "Default Tab"), inComponent: 0, animated: true)
        
        defaultTipSegmentedControl.selectedSegmentIndex = preferences.integer(forKey: "Default Tip")
        
        stepper.autorepeat = true
        stepper.maximumValue = 5.0
        stepper.minimumValue = 0.1
        stepper.stepValue = 0.1
        
        if preferences.double(forKey: "Stride Length") == 0.0 {
            stepper.value = 2.4
        } else {
            stepper.value = preferences.double(forKey: "Stride Length")
        }
        strideLength.text = "\(stepper.value)"
    
    }

    // MARK: Actions
    @IBAction func stepperAction(_ sender: UIStepper) {
        strideLength.text = "\(stepper.value)"
        print("stepper value: \(stepper.value)")
        
        preferences.set(stepper.value, forKey: "Stride Length")
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func changeDefaultTipAction(_ sender: UISegmentedControl) {
        preferences.set(defaultTipSegmentedControl.selectedSegmentIndex, forKey: "Default Tip")
    }
    
    @IBAction func tappedStrideInfoButton(_ sender: UIButton) {
        
        Helper.showAlert(title: "Stride Length", message: "Stride length is the distance between each step. The average stride length is 2.2 feet for women and 2.5 feet for men. To calculate your own stride length, walk 10 steps, measure the distance, divide it by 10.", from: self)
    }
    
}

extension SettingsViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tabPickerData.count
    }
    
}

extension SettingsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tabPickerData[row]
    }
    
    // Saves the default tab selection to UserDefaults
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(tabPickerData[row])
        
        switch tabPickerData[row]{
        case "News":
            preferences.set(0, forKey: "Default Tab")
        case "Tip Calculator":
            preferences.set(1, forKey: "Default Tab")
        case "Metrocard Calculator":
            preferences.set(2, forKey: "Default Tab")
        case "Steps Calculator":
            preferences.set(3, forKey: "Default Tab")
        default:
            preferences.set(0, forKey: "Default Tab")
        }
    }
    
}
