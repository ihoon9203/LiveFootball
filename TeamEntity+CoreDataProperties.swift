//
//  TeamEntity+CoreDataProperties.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 8/1/22.
//
//

import Foundation
import CoreData


extension TeamEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamEntity> {
        return NSFetchRequest<TeamEntity>(entityName: "TeamEntity")
    }

    @NSManaged public var id: NSDecimalNumber?
    @NSManaged public var data: CDTeamData?
    @NSManaged public var hasPlayer: PlayerEntity?

}

extension TeamEntity : Identifiable {

}
