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
        
        let reachability = Reachability()!
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        
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
                
                print("Total articles: \(articlesArray.count)")
                
                
                
                context.perform {
                    
                    // Get News from newsAPI Step 3: Delete from Core Data (if exists)
                    let fetchRequest = NSFetchRequest<Article>(entityName: "Article")
                    
                    if let count = try? context.count(for: fetchRequest){
                        if count > 0 {
                            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
                            
                            do {
                                let batchResult = try context.execute(deleteRequest) as! NSBatchDeleteResult
                                print("Records deleted: \(batchResult.result!)")
                            } catch let error as NSError {
                                print("Unable to batch delete article objects: \(error), \(error.userInfo)")
                            }
                        }
                    }
            
                    
                    // Create article object
                    let articleObject = Article(context: context)
                    
                    let dateFor = DateFormatter()
                    dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
                    
                    for article in articlesArray{
                        
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
                    
                }
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Unable to save \(error), \(error.userInfo)")
                }
            })
            
            task.resume()
            
            //let filledFRC = self.fillFRC(managed: context)
            
            return self.fillFRC(managed: context)
            
            
        }
        else {
            print("No internet connection")
        }
    
        reachability.stopNotifier()
        
        return fillFRC(managed: context)
    }
    
}


/*
 
 (lldb) po article["title"] as String
 "Fidel Castro, Cuban Revolutionary Who Defied U.S., Dies at 90"
 
 
 Fix-it applied, fixed expression was:
 article["title"] as! String
 (lldb) po article["url"] as! String
 "http://www.nytimes.com/2016/11/26/world/americas/fidel-castro-dies.html"
 
 
 (lldb) po article["publishedAt"] as! Date
 Could not cast value of type '__NSCFString' (0x39311cc) to 'NSDate' (0x393176c).
 error: Execution was interrupted, reason: signal SIGABRT.
 The process has been returned to the state before expression evaluation.
 (lldb) po article["publishedAt"] as! String
 "2016-11-26T16:14:35Z"
 
 
 {
 "status": "ok",
 "source": "the-new-york-times",
 "sortBy": "top",
 "articles": [
 {
 "author": "Anita Gates",
 "title": "Florence Henderson, Upbeat Mom of ‘The Brady Bunch,’ Dies at 82",
 "description": "Her career began with stage musicals, but Ms. Henderson’s touchstone role as the perky matriarch of a 1970s blended family made her an enduring TV presence for decades.",
 "url": "http://www.nytimes.com/2016/11/25/arts/television/florence-henderson-brady-bunch-dies.html",
 "urlToImage": "https://static01.nyt.com/images/2016/11/26/arts/26henderson-obit-1/26henderson-obit-1-facebookJumbo.jpg",
 "publishedAt": "2016-11-26T07:08:43Z"
 },
 {
 "author": "Charles M. Blow",
 "title": "No, Trump, We Can’t Just Get Along",
 "description": "You don’t get a pat on the back for ratcheting down from rabid.",
 "url": "http://www.nytimes.com/2016/11/23/opinion/no-trump-we-cant-just-get-along.html",
 "urlToImage": "https://static01.nyt.com/images/2016/11/24/opinion/24blowWeb/24blowWeb-facebookJumbo-v3.jpg",
 "publishedAt": "2016-11-26T04:32:04Z"
 },
 */



/*
 {
 "photos": {
 "page": 1,
 "pages": 8,
 "perpage": 250,
 "total": "1902",
 "photo": [
 {
 "id": "30414730454",
 "owner": "23120543@N02",
 "secret": "3cc432e71f",
 "server": "5333",
 "farm": 6,
 "title": "At home...",
 "ispublic": 1,
 "isfriend": 0,
 "isfamily": 0,
 "url_m": "https://farm6.staticflickr.com/5333/30414730454_3cc432e71f.jpg",
 "height_m": "500",
 "width_m": "500"
 },
 */
