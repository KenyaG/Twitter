//
//  ProfileViewController.swift
//  TwitterApp
//
//  Created by Kenya Gordon on 6/30/16.
//  Copyright © 2016 Kenya Gordon. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileTableView: UITableView!
    
    var userTweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.userTimeLine((User.currentUser?.idStr!)!, success: { (userTweets: [Tweet]) in
            // code
        
            print("got some tweets over here")
            self.userTweets = userTweets
            self.profileTableView.reloadData()
            for userTweet in userTweets {
                print (userTweet.text)
            }
            
        }, failure: { (error: NSError)-> () in
                print(error.localizedDescription)
    })

        
        profileTableView.dataSource = self
        profileTableView.delegate = self


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        print("number of rows called")
        return userTweets.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        print("cell  for row called")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UserTweetsCell", forIndexPath: indexPath) as! UserTweetsCell
        
        cell.userTweet = userTweets[indexPath.row]
        
        return cell
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
