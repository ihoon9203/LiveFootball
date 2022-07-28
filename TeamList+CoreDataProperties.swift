//
//  TeamList+CoreDataProperties.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/28/22.
//
//

import Foundation
import CoreData


extension TeamList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamList> {
        return NSFetchRequest<TeamList>(entityName: "TeamList")
    }

    @NSManaged public var id: NSDecimalNumber?
    @NSManaged public var logo: Data?
    @NSManaged public var name: String?

}

extension TeamList : Identifiable {

}
