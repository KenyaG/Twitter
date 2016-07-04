//
//  User.swift
//  TwitterApp
//
//  Created by Kenya Gordon on 6/27/16.
//  Copyright © 2016 Kenya Gordon. All rights reserved.
//

import UIKit

class User: NSObject {

    //created variables b/c easier instead of using dictionary keys
    var name: NSString?
    var screenname:NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    var defaultProfileImage:NSString?
    var dictionary: NSDictionary?
    var idStr : String?
    var userId: Int?
    //var followersCount: Int?
    //create an initalizer
    //takes in dictionary so that can take info from the dict.
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
//        print("user: \(user)")
//        print("name: \(user["name"])")
//        print("screenname: \(user["screen_name"])")
//        print("profile url: \(user["profile_image_url_https"])")
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        idStr = dictionary["id_str"] as? String
        //followersCount = dictionary["friends_count"] as? Int
       
        //defaultProfileImage = dictionary["default_profile_image"] as? String
        let profileUrlString = dictionary["default_profile_image"] as? String
       if let profileUrlString = profileUrlString{
        profileUrl = NSURL(string: profileUrlString)
        
        }
        tagline = dictionary["description"] as? String
        
        
        
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser:User?
    
    //class property
    //to get the current user
    class var currentUser: User?{
        get{
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
                if let userData = userData{
                    let dictionary = try!
                        NSJSONSerialization.JSONObjectWithData(userData, options:[]) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                    
                    
                }
                
            }
            return _currentUser
        }
        
        //set currentUser
        set(user){
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
                
            }
            
            // user.dictionary
            
            //like command s .. saves it to disk
            defaults.synchronize()
        }
    }
    
    

}