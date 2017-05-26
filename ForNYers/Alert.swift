//
//  Alert.swift
//  ForNYers
//
//  Created by Jack Ngai on 12/10/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import UIKit

// This class was created to refactor the alert messages code.
// It also hides the loading indicator and gray alpha layer if an error occurs during the loading process.

class Alert:UIViewController{
    
    internal static var alertController:UIAlertController!
    
    internal static func show(title alertTitle: String, message alertMessage: String) {
    
        alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(action)
        guard let keyWindow = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        DispatchQueue.main.async {
            keyWindow.present(alertController, animated: true)
            if let vc = keyWindow.childViewControllers[0] as? NewsViewController {
                vc.loadingIndicator.stopAnimating()
            }
            
        }
    }
    
    internal static func show(title alertTitle: String, message alertMessage: String, from viewController: UIViewController) {
        alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(action)
        viewController.present(alertController, animated: true)
        
    }
    
    internal static func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            if let vc = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0] as? NewsViewController {
                vc.loadingIndicator.stopAnimating()
            }
            
        }
        
    }
    
    
    
}
