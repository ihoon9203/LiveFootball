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
    func enlistCountries(countryList: [Country]) {
        if getAllCountries().count == 0 {
            guard let countryEntity = NSEntityDescription.entity(forEntityName: "CountryEntity", in: managedContext) else { return }// creating reference from data model
            for country in countryList {
                let countryContextObject = NSManagedObject(entity: countryEntity, insertInto: managedContext) as! CountryEntity
                countryContextObject.flag = country.flag
                countryContextObject.name = country.name
                countryContextObject.code = country.code
            }
            DispatchQueue.main.async {
                self.appDelegate.saveContext()
            }
        }
    }
    func getAllCountries() -> [Country] {
        var nations: [Country] = []
        let fetchNationsRequest = NSFetchRequest<CountryEntity>(entityName: "CountryEntity")
        do {
            let nationEntities = try managedContext.fetch(fetchNationsRequest) // as [CountryEntity]
            for nation in nationEntities {
                nations.append(Country(entity: nation))
            }
        } catch {
            print(error)
        }
        return nations
    }
//    func readCountry(code: String) -> Country? {
//        guard NSEntityDescription.entity(forEntityName: "CountryEntity", in: managedContext) != nil else { return nil }
//        let fetchRequest = NSFetchRequest<CountryEntity>(entityName: "CountryEntity")
//        fetchRequest.predicate = NSPredicate(format: "code = %@", code)
//
//        do {
//            let result = try managedContext.fetch(fetchRequest)
//            let countryEntity = result.first!
//            let country = Country(name: countryEntity.name, code: countryEntity.code, flag: countryEntity.flag)
//            return country
//        } catch {
//            print("no such country exist")
//            return nil
//        }
//    }
    func savePlayerToWatchList(info: PlayerInfo) {
        guard let playerEntity = NSEntityDescription.entity(forEntityName: "PlayerEntity", in: managedContext) else { return }// creating reference from data model
        let playerObject = NSManagedObject(entity: playerEntity, insertInto: managedContext) as! PlayerEntity
        playerObject.id = info.player.id as? NSDecimalNumber
        playerObject.data = CDPlayerData(info: info)
        DispatchQueue.main.async {
            self.appDelegate.saveContext()
        }
    }
    func saveTeamToWatchList(team: Team, standing: TeamWithStandingModel) {
        guard let teamEntity = NSEntityDescription.entity(forEntityName: "TeamEntity", in: managedContext) else { return }// creating reference from data model
        let teamObject = NSManagedObject(entity: teamEntity, insertInto: managedContext) as! TeamEntity
        teamObject.id = team.team.id as? NSDecimalNumber
        teamObject.data = CDTeamData(team: team, standing: standing)
        DispatchQueue.main.async {
            self.appDelegate.saveContext()
        }
    }
    func retrievePlayersAndTeamsFromWatchList() -> ([PlayerEntity]?,[TeamEntity]?) {
        let watchedPlayers: [PlayerEntity]?
        let watchedTeams: [TeamEntity]?
        let fetchTeamRequest = NSFetchRequest<TeamEntity>(entityName: "TeamEntity")
        let fetchPlayerRequest = NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
        do {
            watchedTeams = try managedContext.fetch(fetchTeamRequest) as [TeamEntity]
            watchedPlayers = try managedContext.fetch(fetchPlayerRequest) as [PlayerEntity]
            return (watchedPlayers, watchedTeams)
        } catch {
            print(error)
            return (nil, nil)
        }
    }
}
