//
//  CoreDataStack.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/26/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//
import Foundation
import CoreData

class CoreDataStack {
    // Shared instance for easy access to CoreDataStack
    class func sharedInstance() -> CoreDataStack {
        struct Static {
            static let instance = CoreDataStack()
        }
        return Static.instance
    }
    
    // Core Data Stack from AppDelegate
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ForNYers")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        print(container.persistentStoreDescriptions)
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        } else {
            print("%% In saveContext. No changes detected. Save cancelled.")
        }
    }
}
 

