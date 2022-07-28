//
//  PlayerList+CoreDataProperties.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/28/22.
//
//

import Foundation
import CoreData


extension PlayerList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerList> {
        return NSFetchRequest<PlayerList>(entityName: "PlayerList")
    }

    @NSManaged public var id: NSDecimalNumber?
    @NSManaged public var photo: Data?
    @NSManaged public var name: String?

}

extension PlayerList : Identifiable {

}
