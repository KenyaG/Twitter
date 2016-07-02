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
            
            
            
        }
    }

        override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        }

}
