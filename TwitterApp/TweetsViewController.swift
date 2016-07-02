//
//  TweetsViewController.swift
//  TwitterApp
//
//  Created by Kenya Gordon on 6/28/16.
//  Copyright © 2016 Kenya Gordon. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
            
            TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) -> () in
                print("got some tweets over here")
                self.tweets = tweets
                
                self.tableView.reloadData()
                
                for tweet in tweets {
                    //print (tweet.text)
                }
                }, failure: { (error: NSError)-> () in
                    print(error.localizedDescription)
            })
        
      
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableView: UITableView!
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return tweets.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        print("cell for row called")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogoutButton(sender: AnyObject) {
        
        TwitterClient.sharedInstance.logout()
        
        
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
            
            }, failure: { (error: NSError)-> () in
                print(error.localizedDescription)
        })
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toDetailView"
        {
            let cell = sender as! TweetCell
            let detailsViewController = segue.destinationViewController as! DetailsViewController
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets[indexPath!.row]
            detailsViewController.tweet = tweet
            
        }
        
    }

}
