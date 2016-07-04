//
//  TwitterClient.swift
//  TwitterApp
//
//  Created by Kenya Gordon on 6/27/16.
//  Copyright © 2016 Kenya Gordon. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "44vZTisNcKN3TSS1SvSjZw2NT", consumerSecret: "LUtZaQsMRuNUUVCKZopP33wuARRGafGBwnIEyBOV2v6qLwCA4m")

    var loginSuccess:(() -> ())?
    var loginFailure:((NSError)-> ())?
    
    
    func login(success: () -> (), failure: (NSError) -> ()){
        
        loginSuccess = success
        loginFailure = failure
        //for logging out... clears the keychains of any previous sessions
        TwitterClient.sharedInstance.deauthorize()
        
        //twitter app in callback URL is an arbitrary extension you created
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            //purpose of the token is to get the permission to send the user to that authorized url
            //print("I got a token!")
            
            //create a url
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            //method that links to another url
            UIApplication.sharedApplication().openURL(url)
            
            
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    
    }
    
        func logout(){
        
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL){
    
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("I got the access token!")
            
            self.currentAccount({ (user: User)-> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                     self.loginFailure?(error)
            })
            
            
            
            
        })  { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
            
        }

    
    }
    
    
    //will fetch the home timeline 
    //the success part is how you declare a closure
    func homeTimeLine(success:([Tweet]) -> (), failure:(NSError) -> ()){
        //Call a closure
        
        
       GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            print("I got some tweets!")
            //print("\(response)")
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)

        
            success(tweets)
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) ->  Void in
            failure(error)
        })

        
    }
    
    func userTimeLine(screenName: String, success:([Tweet]) -> (), failure:(NSError) -> ()){
    
        let parameters = ["user_id" : screenName]
        GET("1.1/statuses/user_timeline.json", parameters: parameters, progress: nil,
            success:{( task: NSURLSessionDataTask?, response: AnyObject?) in
                
                let dictionaries = response as! [NSDictionary]
                let userTweets = Tweet.tweetsWithArray(dictionaries)
                success(userTweets)
                
            }, failure:{ (task: NSURLSessionDataTask?, error: NSError) ->  Void in
                
                failure(error)
        })

        
    }
    
    func reTweet(id: String, retweetWorkedCallback:(Tweet) -> Void, retweetDidntWorkCallback: (NSError) -> Void){
        
            POST("1.1/statuses/retweet/\(id).json", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            
                    print("I retweeted the status!")
                let tweetDictionary = response as! NSDictionary
                let retweet = Tweet(dictionary: tweetDictionary)
                
                retweetWorkedCallback(retweet)
                
                
                }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                    retweetDidntWorkCallback(error)
            })
    
    }
    
    func favorite(id: String, success: (Tweet) -> Void, failure: (NSError) -> Void) {
        let params = ["id" : id]
        
        POST("1.1/favorites/create.json", parameters: params, success: {(task: NSURLSessionDataTask,response: AnyObject?) in
        
        let favoriteDictionary = response as! NSDictionary
        let favorite = Tweet(dictionary: favoriteDictionary)
        
            success(favorite)
            }, failure:{ (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
    
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile url: \(user.profileUrl)")
            print("description:\(user.tagline)")
            
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
                
                })
    }
    
    
    
    }

