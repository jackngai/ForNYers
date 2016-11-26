//
//  NewsViewController.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/23/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var newsTableView: UITableView!
    
    var newsArray : [String] = []
    
    var context = CoreDataStack.sharedInstance().persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NewsClient.sharedInstance().getNews(managed: context)
        
        
        
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
    
}

