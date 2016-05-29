//
//  TweeterUserTableViewController.swift
//  TweetTableView
//
//  Created by Abiodun Shuaib on 29/05/2016.
//  Copyright © 2016 Abiodun Shuaib. All rights reserved.
//

import UIKit
import CoreData

class TweeterUserTableViewController: CoreTableViewController {
    var mention: String?
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            updateUI()
        }
    }
    private func updateUI(){
        if let context = managedObjectContext where mention?.characters.count > 0 {
            let request = NSFetchRequest(entityName: "TwitterUser")
            request.predicate = NSPredicate(format: "any tweets.text contains[c] %@ and !screeName beginswith %@", mention!, "dark")
            request.sortDescriptors = [NSSortDescriptor(key: "screeName", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context, sectionNameKeyPath: nil,
                cacheName: nil)
        }
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetsCell", forIndexPath: indexPath)
        if let tweet = fetchedResultsController?.objectAtIndexPath(indexPath) as? TwitterUser {
            var screenName: String?
            var detail: String?
            tweet.managedObjectContext?.performBlockAndWait {
                screenName = tweet.screeName
                detail = tweet.name
            }
            cell.textLabel?.text = screenName
            if let count = tweetMentionByTwitterUser(tweet) {
                cell.detailTextLabel?.text = count == 1 ? "1 tweet" : "\(count) Tweets"
            } else {
                cell.detailTextLabel?.text = detail
            }
            
        }
        return cell
    }
    
    private func tweetMentionByTwitterUser(user: TwitterUser) -> Int? {
        var count: Int?
        user.managedObjectContext?.performBlock {
            let request = NSFetchRequest(entityName: "Tweets")
            request.predicate = NSPredicate(format: "text contains[c] %@ and tweeters = %@", self.mention!, user)
            count = user.managedObjectContext?.countForFetchRequest(request, error: nil)
        }
        return count
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
