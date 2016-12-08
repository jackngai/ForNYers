//
//  AppDelegate.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/23/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import UIKit
import XCGLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let log = XCGLogger.default


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        log.setup(level: .verbose, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil, fileLevel: .debug)
        
        let preferences = UserDefaults.standard
        
        // MARK: Test Code - Set default to a different tab
        // Change the default tab: http://stackoverflow.com/questions/30886360/set-the-second-tab-as-default-tab-in-swift/
        if window?.rootViewController as? UITabBarController != nil {
            let tabBarController = window!.rootViewController as! UITabBarController
            tabBarController.tabBar.tintColor = .black
            tabBarController.selectedIndex = preferences.integer(forKey: "Default Tab")
        }
        // End test code
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

