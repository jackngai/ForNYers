//
//  Helper.swift
//  ForNYers
//
//  Created by Jack Ngai on 12/10/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import UIKit

class Helper:UIViewController{
    
    internal static var alertController:UIAlertController!
    
    internal static func showAlert(title alertTitle: String, message alertMessage: String) {
    
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
    
    internal static func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            if let vc = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0] as? NewsViewController {
                vc.loadingIndicator.stopAnimating()
            }
            
        }
        
    }
    
    
    
}
