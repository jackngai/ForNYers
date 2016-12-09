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



