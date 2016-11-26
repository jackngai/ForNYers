//
//  NewsConstants.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/25/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import Foundation

enum NewsConstants{
    
    //https://newsapi.org/v1/articles
    
    static let APIScheme = "https"
    static let APIHost = "newsapi.org"
    static let APIPath = "/v1/articles"
    
    enum ParameterKeys {
        static let Source = "source"
        static let APIKey = "apiKey"
        static let sortBy = "sortBy"
    }
    
    enum ParameterValues {
        static let Source = "the-new-york-times"
        static let APIKey = "2e900a5379054e8d8c5f097ec992aeb2"
        static let sortBy = "top" //top, latest, popular
    }
    
    enum ResponseKeys {
        static let status = "status"
        static let source = ""
        static let sortBy = ""
        static let articles = "articles"
    }
    
}


/*
 
 {
 "status": "ok",
 "source": "the-new-york-times",
 "sortBy": "top",
 "articles": [
 {
 "author": "Charles M. Blow",
 "title": "No, Trump, We Can’t Just Get Along",
 "description": "You don’t get a pat on the back for ratcheting down from rabid.",
 "url": "http://www.nytimes.com/2016/11/23/opinion/no-trump-we-cant-just-get-along.html",
 "urlToImage": "https://static01.nyt.com/images/2016/11/24/opinion/24blowWeb/24blowWeb-facebookJumbo-v3.jpg",
 "publishedAt": "2016-11-26T00:24:05Z"
 },
 {
 "author": "Jeremy W. Peters and Maggie Haberman",
 "title": "Republicans Divided Between Romney and Giuliani for Secretary of State",
 "description": "The leading candidates are both high-profile politicians with their share of detractors.",
 "url": "http://www.nytimes.com/2016/11/24/us/politics/donald-trump-mitt-romney-rudy-giuliani-state.html",
 "urlToImage": "https://static01.nyt.com/images/2016/11/25/us/25state1/25state1-facebookJumbo.jpg",
 "publishedAt": "2016-11-26T03:06:32Z"
 },
 
 */
