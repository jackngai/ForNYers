//
//  NewsConvenience.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/25/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import UIKit
import CoreData
import ReachabilitySwift

extension NewsClient {
    
    func startReachability()->Reachability{
        let reachability = Reachability()!
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        return reachability
    }
    
    func deleteOldNews(managed context: NSManagedObjectContext){
        
        
        let reachability = startReachability()
        
        if reachability.isReachable{
            // Get News from newsAPI Step 3: Delete from Core Data (if exists)
            let fetchRequest = NSFetchRequest<Article>(entityName: "Article")
            
            if let count = try? context.count(for: fetchRequest){
                if count > 0 {
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
                    
                    deleteRequest.resultType = .resultTypeCount
                    
                    do {
                        let batchResult = try context.execute(deleteRequest) as! NSBatchDeleteResult
                        self.appDelegate.log.verbose("Records deleted: \(batchResult.result!)")
                    } catch let error as NSError {
                        print("Unable to batch delete article objects: \(error), \(error.userInfo)")
                    }
                }
                else {
                    appDelegate.log.verbose("No old news found")
                }
            }
        } else {
            appDelegate.log.verbose("No internet connection - keeping old news")
        }
        reachability.stopNotifier()
    }
    
    func fillFRC(managed context: NSManagedObjectContext)->NSFetchedResultsController<Article>{
        // Display news from Core Data Step 1: Create fetch request
        let fetchRequest : NSFetchRequest<Article> = Article.fetchRequest()
        
        // Display news from Core Data Step 2: Set sort descriptor
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Article.publishedAt), ascending: false)
        
        // Display news from Core Data Step 3: Add sort descriptor to fetch request
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Display news from Core Data Step 4: Instantiate Fetch Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: context,
                                                                   sectionNameKeyPath: nil, cacheName: nil)
        
        // Display news from Core Data Step 5: Execute the fetch
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetch error: \(error), \(error.userInfo)")
        }
        
        appDelegate.log.verbose(fetchedResultsController.fetchedObjects?.count)
        return fetchedResultsController 
    }
    
    func getNews(managed context: NSManagedObjectContext)->NSFetchedResultsController<Article>{
        
        let reachability = startReachability()
        
        
        // Get News from newsAPI Step 2: If internet is available, download from newsAPI
        if reachability.isReachable{
            // Setup the parameters
            let methodParameters: [String:String?] = [
                NewsConstants.ParameterKeys.Source:NewsConstants.ParameterValues.Source,
                NewsConstants.ParameterKeys.APIKey:NewsConstants.ParameterValues.APIKey,
                NewsConstants.ParameterKeys.sortBy:NewsConstants.ParameterValues.sortBy
            ]
            
            // Setup the request using parameters
            let getRequest = NewsClient.sharedInstance().get(parameters: methodParameters as [String: AnyObject])
        
            
            // Start the task
            let task = NewsClient.sharedInstance().startTask(request: getRequest, completionHandlerForTask: {
                (data, error) in
                guard error == nil else {
                    print("Received error getting news from NewsAPI.org")
                    return
                }
                
                guard let data = data else {
                    print("Unable to unwrap data")
                    return
                }
                
                // Pull out the articlesDictionary from data, pull out the article from articlesDictionary
                guard let articlesArray = data[NewsConstants.ResponseKeys.articles] as? [[String:AnyObject]] else {
                    print("Unable to find articles in data from newsAPI")
                    return
                }
                
                // MARK: Debug Code
                print("Total articles: \(articlesArray.count)")
                // End Debug Code
                
                
                context.perform {
                    

            
                    let dateFor = DateFormatter()
                    dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
                    
                    
                    let entity = NSEntityDescription.entity(forEntityName: "Article", in: context)!
                    
                    for article in articlesArray{
                        
                        let articleObject =  Article(entity: entity, insertInto: context)
                        articleObject.author = article["author"] as? String ?? ""
                        articleObject.desc = article["description"] as? String ?? ""
                        articleObject.title = article["title"] as? String ?? ""
                        articleObject.url = article["url"] as? String ?? ""
                        articleObject.publishedAt = dateFor.date(from: article["publishedAt"] as? String ?? "") as NSDate?

                        guard let imageURL = URL(string: article["urlToImage"] as? String ?? ""),
                            let imageData = try? Data(contentsOf: imageURL) else {
                                print("Unable to process url into image")
                                fatalError("Unable to process url into image")
                        }
                        articleObject.image = imageData as NSData?
                    }
                    
                    if let vc = self.appDelegate.window?.rootViewController?.childViewControllers[0] as? NewsViewController {
                        vc.loadingIndicator.stopAnimating()
                    }
            
                    
                    do {
                        try context.save()
                        self.appDelegate.log.verbose("Saved to Core Data")
                    } catch let error as NSError {
                        print("Unable to save \(error), \(error.userInfo)")
                    }
                    
                }
            
            })
            
            task.resume()
            
            return self.fillFRC(managed: context)
            
        }
        else {
            print("No internet connection")

            // Notify the NewsViewController to show the alert that there's no internet connection
            if let vc = appDelegate.window?.rootViewController?.childViewControllers[0] as? NewsViewController {
                vc.internetConnection = false
                vc.loadingIndicator.stopAnimating()
            }
            
        }
    
        reachability.stopNotifier()
        
        return fillFRC(managed: context)

    }
    
}



