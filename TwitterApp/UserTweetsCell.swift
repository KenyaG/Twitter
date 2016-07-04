//
//  UserTweetsCell.swift
//  TwitterApp
//
//  Created by Kenya Gordon on 6/30/16.
//  Copyright © 2016 Kenya Gordon. All rights reserved.
//

import UIKit

class UserTweetsCell: UITableViewCell {
    
    @IBOutlet weak var atName: UILabel!
  
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetsLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var reTweetLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    var userTweet: Tweet? {
        didSet {
            print("we have a tweet in the cell")
            tweetsLabel.text = userTweet!.text
            //followingLabel.text = String(userTweet!.followingCount!)
            let ppURL = NSURL(string: userTweet!.profilePic!)
            //print(ppURL)
            profileImage.setImageWithURL(ppURL!)
            atName.text = userTweet!.atName
            usernameLabel.text = userTweet!.name
            
            if let innerTweet = userTweet!.innerTweet {
                // if this is a retweet, we should display the inner tweet count
                reTweetLabel.text = "\(innerTweet.retweetCount)"
                likesLabel.text = "\(innerTweet.favoritesCount)"
            }else {
                // if not, we should deplay the retweet count
                reTweetLabel.text = String(userTweet!.retweetCount)
                likesLabel.text = String(userTweet!.favoritesCount)
            }
            
        }
    }

    
    @IBAction func onRetweet(sender: AnyObject) {
        
        TwitterClient.sharedInstance.reTweet(userTweet!.idStr!,
                                             retweetWorkedCallback: { (retweet : Tweet) -> Void in
                                                if let innerTweet = retweet.innerTweet {
                                                    // if this is a retweet, we should display the inner tweet count
                                                    self.reTweetLabel.text = String(innerTweet.retweetCount)
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
        
        TwitterClient.sharedInstance.favorite(userTweet!.idStr!, success: { (favorite : Tweet) -> Void in
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
