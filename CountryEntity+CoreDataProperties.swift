//
//  CountryEntity+CoreDataProperties.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/28/22.
//
//

import Foundation
import CoreData


extension CountryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryEntity> {
        return NSFetchRequest<CountryEntity>(entityName: "CountryEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var code: String?
    @NSManaged public var flag: String?

}

extension CountryEntity : Identifiable {

}
