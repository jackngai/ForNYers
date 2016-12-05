//
//  NewsViewController.swift
//  ForNYers
//
//  Created by Jack Ngai on 11/23/16.
//  Copyright © 2016 Jack Ngai. All rights reserved.
//

import UIKit
import CoreData
import XCGLogger

class NewsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var newsTableView: UITableView!
    
    // MARK: Properties
    
    fileprivate let newsCellReuseIdentifier = "newsCell"
    
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    var context = CoreDataStack.sharedInstance().persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<Article>!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Dynamic Row Height
        newsTableView.rowHeight = UITableViewAutomaticDimension
        newsTableView.estimatedRowHeight = 220
        
        // Get News from newsAPI Step 1: Call Get news and provide it the managed context
        // (Step 2 in NewsConvenience.swift)
        
        fetchedResultsController = NewsClient.sharedInstance().getNews(managed: context)
        
        fetchedResultsController.delegate = self
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
    
    // MARK: Actions
    @IBAction func reload(_ sender: Any) {
        newsTableView.reloadData()
        
    }
    
    
}

// MARK: Internal
extension NewsViewController {
    
    func configure(cell: UITableViewCell, for indexPath: IndexPath){
        
        guard let cell = cell as? NewsTableViewCell else {
            return
        }
        
        let newsItem = fetchedResultsController.object(at: indexPath)
        
        let formatter = DateFormatter()
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.dateFormat = "MM-dd-yyyy hh:MM a"
        let stringDate: String = formatter.string(from: newsItem.publishedAt as! Date)
        print(stringDate)
        
        cell.newsTitle.text = newsItem.title
        cell.newsDescription.text = newsItem.desc
        cell.newsDate.text = formatter.string(from: newsItem.publishedAt as! Date)
        cell.newsBy.text = newsItem.author
        
        let image = UIImage(data: newsItem.image as! Data)!
        
        cell.newsImage.image = image
        
    }
    
}

// MARK: UITableViewDelegate
extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sectionInfo = fetchedResultsController.sections?[section] else {
        return 0
        }
        
        appDelegate.log.verbose(sectionInfo.numberOfObjects)
        return sectionInfo.numberOfObjects

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellReuseIdentifier, for: indexPath)
        configure(cell: cell, for: indexPath)
        return cell
    }
    
}

extension NewsViewController: UITableViewDelegate {
    
}

extension NewsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        newsTableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            newsTableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            newsTableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            let cell = newsTableView.cellForRow(at: indexPath!) as! NewsTableViewCell
            configure(cell: cell, for: indexPath!)
        case .move:
            newsTableView.deleteRows(at: [indexPath!], with: .automatic)
            newsTableView.insertRows(at: [newIndexPath!], with: .automatic)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        newsTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            newsTableView.insertSections(indexSet, with: .automatic)
        case .delete:
            newsTableView.deleteSections(indexSet, with: .automatic)
        default:
            break
        }
        
    }
    
}


