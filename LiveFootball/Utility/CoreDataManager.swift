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
        DispatchQueue.main.async {
            self.appDelegate.saveContext()
        }
    }
    func readCountry(code: String) -> Country? {
        guard NSEntityDescription.entity(forEntityName: "CountryEntity", in: managedContext) != nil else { return nil }
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
    func savePlayerToWatchList(info: PlayerCoreDataInfo) {
        guard let playerList = NSEntityDescription.entity(forEntityName: "PlayerList", in: managedContext) else { return }// creating reference from data model
        let playerObject = NSManagedObject(entity: playerList, insertInto: managedContext) as! PlayerList
        playerObject.id = info.id as? NSDecimalNumber
        playerObject.name = info.name
        playerObject.photo = info.photo
        DispatchQueue.main.async {
            self.appDelegate.saveContext()
        }
    }
    func saveTeamToWatchList(info: TeamCoreDataInfo) {
        guard let teamList = NSEntityDescription.entity(forEntityName: "TeamList", in: managedContext) else { return }// creating reference from data model
        let teamObject = NSManagedObject(entity: teamList, insertInto: managedContext) as! TeamList
        teamObject.id = info.id as? NSDecimalNumber
        teamObject.name = info.name
        teamObject.logo = info.logo
        DispatchQueue.main.async {
            self.appDelegate.saveContext()
        }
    }
    func retrievePlayersAndTeamsFromWatchList() -> ([PlayerList]?,[TeamList]?) {
        var watchedPlayers: [PlayerList] = []
        var watchedTeams: [TeamList] = []
        let fetchTeamRequest = NSFetchRequest<TeamList>(entityName: "TeamList")
        let fetchPlayerRequest = NSFetchRequest<PlayerList>(entityName: "PlayerList")
        do {
            let teamResult = try managedContext.fetch(fetchTeamRequest) as [TeamList]
            let playerResult = try managedContext.fetch(fetchPlayerRequest) as [PlayerList]
            watchedTeams = teamResult
            watchedPlayers = playerResult
        } catch {
            print(error)
        }
        return (watchedPlayers, watchedTeams)
    }
}
