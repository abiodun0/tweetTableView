//
//  TwitterUser+CoreDataProperties.swift
//  TweetTableView
//
//  Created by Abiodun Shuaib on 29/05/2016.
//  Copyright © 2016 Abiodun Shuaib. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TwitterUser {

    @NSManaged var screeName: String?
    @NSManaged var name: String?
    @NSManaged var newRelationship: NSSet?

}
