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
            //screennameLabel.text = "@\(tweet!.atName)"
            userName.text = tweet!.name
            //retweetsLabel.text = tweet!.retweetCount
           // timeLabel.text = NSDate(timestamp)
            
            if let innerTweet = tweet!.innerTweet {
                // if this is a retweet, we should display the inner tweet count
                retweetsLabel.text = "\(innerTweet.retweetCount)"
                likesLabel.text = "\(innerTweet.favoritesCount)"
            }else {
                // if not, we should deplay the retweet count
                retweetsLabel.text = String(tweet!.retweetCount)
                likesLabel.text = String(tweet!.favoritesCount)
            }
        
        }
    }
    
    
//    var screenID: User?
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        TwitterClient.sharedInstance.reTweet(tweet!.idStr!,
            retweetWorkedCallback: { (retweet : Tweet) -> Void in
                if let innerTweet = retweet.innerTweet {
                    // if this is a retweet, we should display the inner tweet count
                    self.retweetsLabel.text = String(innerTweet.retweetCount)
                }else {
                    print("should have received an inner tweet!")
                }
            },
            retweetDidntWorkCallback: { (error : NSError) -> Void in
                print("retweet error: \(error)")
        })
        
                //TwitterClient.sharedInstance.reTweet(NSNumber)
        
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        
        TwitterClient.sharedInstance.favorite(tweet!.idStr!, success: { (favorite : Tweet) -> Void in
            if let innerTweet = favorite.innerTweet{
                self.likesLabel.text = String(innerTweet.favoritesCount)}
            else{
                print("should have inner tweet to favorite")
            }
        },
            failure:  {(error : NSError) -> Void in
                print("like error: \(error)")
            
            })
      
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
