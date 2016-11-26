//
//  NewsConvenience.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/25/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import Foundation
import CoreData

extension NewsClient {
    
    func getNews(managed context: NSManagedObjectContext){
        
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
            
            for article in articlesArray{
                
                print("\(article["author"])")
            }
            
//            context.perform {
//                
//                // Create article object
//                let articleObject = Article(context: context)
//                
//                for article in articlesArray{
//                    
//                    articleObject.author = article[]
//                    
//                }
//                
//                
//                
//            }

        })
        
        task.resume()
        
    }
    
}


/*
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
