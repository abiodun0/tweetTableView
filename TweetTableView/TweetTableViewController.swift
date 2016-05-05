//
//  TweetTableViewController.swift
//  TweetTableView
//
//  Created by Abiodun Shuaib on 02/05/2016.
//  Copyright © 2016 Abiodun Shuaib. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController, UITextFieldDelegate {
    
    var tweets = [[Tweet]]()
    var lastSuccessfulRequest: TwitterRequest?
    var nextRequest: TwitterRequest {
        if lastSuccessfulRequest == nil  && searchText != nil{
            return TwitterRequest(search: searchText!, count: 100)
        }
        return lastSuccessfulRequest!.requestForNewer!
    }

    @IBAction func refresh(sender: UIRefreshControl?) {
        if searchText != nil {
            let request = nextRequest
            request.fetchTweets { (newTweets) -> Void in
                print(newTweets)
                
                dispatch_async(dispatch_get_main_queue()) {
                    if newTweets.count > 0 {
//                        self.lastSuccessfulRequest = request
                        self.tweets.insert(newTweets, atIndex: 0)
                        self.tableView.reloadData()
                        sender?.endRefreshing()
                    }
                }
                
            }
            
        }else{
            sender?.endRefreshing()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        refresh()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    var searchText: String? = "#stanford" {
        didSet{
            lastSuccessfulRequest = nil
            SearchTextField?.text = searchText
            tweets.removeAll()
            tableView.reloadData()
            refresh()
        }
    }
    // MARK: - Table view data source
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == SearchTextField{
            textField.resignFirstResponder()
            searchText = textField.text
        }
        return true
    }
    
    private func refresh(){
        if refreshControl == nil {
            refreshControl?.beginRefreshing()
        }
        refresh(refreshControl)
    }
    
    @IBOutlet weak var SearchTextField: UITextField!{
        didSet{
            SearchTextField.delegate = self
             SearchTextField.text = searchText
        }
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tweets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets[section].count
    }

    private struct StoryBoard{
        static let tweetCell = "Tweet"
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.tweetCell, forIndexPath: indexPath) as! TweetTableViewCell
        cell.tweet = tweets[indexPath.section][indexPath.row]
//        cell.textLabel?.text = tweet.text
//        cell.detailTextLabel?.text = tweet.user.name

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
