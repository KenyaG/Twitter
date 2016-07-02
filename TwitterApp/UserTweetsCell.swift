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
    
    var userTweet: Tweet? {
        didSet {
            print("we have a tweet in the cell")
            tweetsLabel.text = userTweet!.text
            
            let ppURL = NSURL(string: userTweet!.profilePic!)
            //print(ppURL)
            profileImage.setImageWithURL(ppURL!)
            atName.text = userTweet!.atName
            usernameLabel.text = userTweet!.name
            
        }
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
