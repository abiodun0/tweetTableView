//
//  Tweets.swift
//  TweetTableView
//
//  Created by Abiodun Shuaib on 29/05/2016.
//  Copyright © 2016 Abiodun Shuaib. All rights reserved.
//

import Foundation
import CoreData


class Tweets: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func createTweetIfNecessary(tweetInfo: Tweet, inManagedbjectContext context: NSManagedObjectContext) -> Tweets?{
       let request = NSFetchRequest(entityName: "Tweets")
        request.predicate = NSPredicate(format: "unique = %@", tweetInfo.id!)
        
        if let tweet = (try? context.executeFetchRequest(request))?.first as? Tweets {
            return tweet
        }
        else if let tweet = NSEntityDescription.insertNewObjectForEntityForName("Tweets", inManagedObjectContext: context) as? Tweets {
            tweet.posted = tweetInfo.created
            tweet.text = tweetInfo.text
            tweet.unique = tweetInfo.id
            tweet.tweeters = TwitterUser.createUserInfNeccessary(tweetInfo.user, inManagedbjectContext: context)
            return tweet
        }
        
//        do {
//            
//            let queryResults = try context.executeFetchRequest(request)
//            if let tweet = queryResults.first as? Tweet {
//                return tweet
//            }
//        }catch let err{
//            print("error \(err)")
//        }
        
        return nil
    }

}
