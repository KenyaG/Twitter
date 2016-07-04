//
//  DetailsViewCell.swift
//  TwitterApp
//
//  Created by Kenya Gordon on 6/30/16.
//  Copyright © 2016 Kenya Gordon. All rights reserved.
//

import UIKit

class DetailsViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var atScreenname: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var tweet: Tweet? {
        didSet {
            print("we have a tweet in the cell")
            tweetsLabel.text = tweet!.text
            let ppURL = NSURL(string: tweet!.profilePic!)
            //print(ppURL)
            profileImage.setImageWithURL(ppURL!)
            atScreenname.text = tweet!.atName
            username.text = tweet!.name
            if let innerTweet = tweet!.innerTweet {
                // if this is a retweet, we should display the inner tweet count
                retweetCountLabel.text = "\(innerTweet.retweetCount)"
                likesLabel.text = "\(innerTweet.favoritesCount)"
            }else {
                // if not, we should deplay the retweet count
                retweetCountLabel.text = String(tweet!.retweetCount)
                likesLabel.text = String(tweet!.favoritesCount)
            }
            

            
            
            
        }
    }

    
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        TwitterClient.sharedInstance.reTweet(tweet!.idStr!,
                                             retweetWorkedCallback: { (retweet : Tweet) -> Void in
                                                if let innerTweet = retweet.innerTweet {
                                                    // if this is a retweet, we should display the inner tweet count
                                                    self.retweetCountLabel.text = String(innerTweet.retweetCount)
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
        override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        }

}
