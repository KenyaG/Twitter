//
//  TweetCell.swift
//  TwitterApp
//
//  Created by Kenya Gordon on 6/28/16.
//  Copyright © 2016 Kenya Gordon. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var tweet: Tweet? {
        didSet {
            print("we have a tweet in the cell")
            tweetTextLabel.text = tweet!.text
            let ppURL = NSURL(string: tweet!.profilePic!)
            //print(ppURL)
            profileImageView.setImageWithURL(ppURL!)
            screennameLabel.text = tweet!.atName
            userName.text = tweet!.name
            
            

        }
    }
    
    
//    var screenID: User?
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        //TwitterClient.sharedInstance.reTweet(NSNumber)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
