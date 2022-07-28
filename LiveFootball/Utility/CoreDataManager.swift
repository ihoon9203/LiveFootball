//
//  CoreDataManager.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let sharedManager = CoreDataManager()
    private var managedContext: NSManagedObjectContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func enlistCountries(countryList: CountryModelList) {
        guard let countryEntity = NSEntityDescription.entity(forEntityName: "CountryEntity", in: managedContext) else { return }// creating reference from data model
        for country in countryList.countries {
            let countryContextObject = NSManagedObject(entity: countryEntity, insertInto: managedContext) as! CountryEntity
            countryContextObject.flag = country.flag
            countryContextObject.name = country.name
            countryContextObject.code = country.code
        }
        appDelegate.saveContext()
    }
    func readCountry(code: String) -> Country? {
        guard let countryEntity = NSEntityDescription.entity(forEntityName: "CountryEntity", in: managedContext) else { return nil }
        let fetchRequest = NSFetchRequest<CountryEntity>(entityName: "CountryEntity")
        fetchRequest.predicate = NSPredicate(format: "code = %@", code)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let countryEntity = result.first!
            let country = Country(name: countryEntity.name, code: countryEntity.code, flag: countryEntity.flag)
            return country
        } catch {
            print("no such country exist")
            return nil
        }
    }
}
