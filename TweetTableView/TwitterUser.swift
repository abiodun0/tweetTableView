//
//  TwitterUser.swift
//  TweetTableView
//
//  Created by Abiodun Shuaib on 29/05/2016.
//  Copyright © 2016 Abiodun Shuaib. All rights reserved.
//

import Foundation
import CoreData


class TwitterUser: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    // Insert code here to add functionality to your managed object subclass
    class func createUserInfNeccessary(tweetInfo: User, inManagedbjectContext context: NSManagedObjectContext) -> TwitterUser?{
        let request = NSFetchRequest(entityName: "TwitterUser")
        request.predicate = NSPredicate(format: "screeName = %@", tweetInfo.screenName)
        
        if let user = (try? context.executeFetchRequest(request))?.first as? TwitterUser {
            return user
        }
        else if let user = NSEntityDescription.insertNewObjectForEntityForName("TwitterUser", inManagedObjectContext: context) as? TwitterUser {
            user.screeName = tweetInfo.screenName
            user.name = tweetInfo.name
            
        }
        return nil
    }

}
