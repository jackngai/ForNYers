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
import ReachabilitySwift

class NewsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    // MARK: Properties
    
    fileprivate let newsCellReuseIdentifier = "newsCell"
    
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    var context = CoreDataStack.sharedInstance().persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<Article>!
    
    var internetConnection = true
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Dynamic Row Height
        newsTableView.rowHeight = UITableViewAutomaticDimension
        newsTableView.estimatedRowHeight = 220
        
        NewsClient.sharedInstance().deleteOldNews(managed: context)
        
        // Get News from newsAPI Step 1: Call Get news and provide it the managed context
        // (Step 2 in NewsConvenience.swift)
        loadingIndicator.sizeToFit()
        loadingIndicator.isHidden = false
        fetchedResultsController = NewsClient.sharedInstance().getNews(managed: context)
        

        fetchedResultsController.delegate = self
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !internetConnection{
            let alertController = UIAlertController(title: "No Internet Connection", message: "Displaying articles from the most recent download.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            
            internetConnection = true
        }
    

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Open the URL for the selected item in a another view
        
        let newsItem = fetchedResultsController.object(at: indexPath)
        
        UIApplication.shared.open(URL(string: newsItem.url!)!)
    }
    
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


