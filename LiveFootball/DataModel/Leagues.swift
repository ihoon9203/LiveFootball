//
//  Leagues.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct Leagues: Codable {
    let response: [League]
}
struct League: Codable {
    let league: LeagueInfo
}
struct LeagueInfo: Codable {
    let id: Int
    let name: String?
    let logo: String?
    let flag: String?
}

struct LeagueModelList {
    var leagues: [LeagueInfo]?
    init(data: Leagues) {
        var localLeagues = [LeagueInfo]()
        var allLeagues = data.response
        allLeagues = allLeagues.sorted { $0.league.id < $1.league.id }
        if (allLeagues.count) > 3 {
            for i in 0...3 {
                localLeagues.append(allLeagues[i].league)
            }
        }
        else {
            for i in 0..<allLeagues.count {
                localLeagues.append(allLeagues[i].league)
            }
        }
        leagues = localLeagues
    }
}
