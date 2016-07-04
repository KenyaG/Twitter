//
//  Tweet.swift
//  TwitterApp
//
//  Created by Kenya Gordon on 6/27/16.
//  Copyright © 2016 Kenya Gordon. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profilePic: String?
    var atName: String?
    var name: String?
    var id: NSNumber?
    var idStr: String?
   // var followingCount: Int?
    var innerTweet: Tweet?
    
    //create initializer
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        profilePic = (dictionary["user"]?["profile_image_url_https"] as?    String)
        
       // followingCount = (dictionary["user"]? ["followers_count"]) as? Int
        atName = (dictionary["user"]? ["screen_name"] as? String)
        name = (dictionary["user"]? ["name"] as? String)
        id = (dictionary["id"] as? Int)
        idStr = (dictionary["id_str"] as? String)
        
       let timestampString = dictionary["created_at"] as? String
        
       if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
            formatter.stringFromDate(timestamp!)
        }
        
        // check if this tweet contains an inner tweet
        if let innerDictionary = dictionary["retweeted_status"] as? NSDictionary {
            // construct a new Tweet from the inner tweet
            innerTweet = Tweet(dictionary: innerDictionary)
        }

        
    }
   
    //this function is going to return an array of tweets
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
       //create an array of tweets //an empty array
        var tweets = [Tweet]()
        
        //iterate through all the dictioaries
        for dictionary in dictionaries {
            //create a tweet based on that dictionary
            let tweet = Tweet(dictionary: dictionary)
            
            //add that tweet to the array
            tweets.append(tweet)
        }
        
        return tweets
    }
    
    
    
    
}
