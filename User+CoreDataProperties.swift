//
//  User+CoreDataProperties.swift
//  FinalProjectSecondSem
//
//  Created by Suraaj Devgn on 23/05/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var game_score: Int64
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
