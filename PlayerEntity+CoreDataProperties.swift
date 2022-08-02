//
//  PlayerEntity+CoreDataProperties.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 8/1/22.
//
//

import Foundation
import CoreData


extension PlayerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerEntity> {
        return NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
    }

    @NSManaged public var data: CDPlayerData?
    @NSManaged public var id: NSDecimalNumber?
    @NSManaged public var contractedWith: TeamEntity?

}

extension PlayerEntity : Identifiable {

}
