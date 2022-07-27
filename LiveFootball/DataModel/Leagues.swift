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
}

struct LeagueModelList {
    var leagues: [LeagueInfo]?
    init(data: Leagues) {
        var localLeagues = [LeagueInfo]()
        var allLeagues = data.response
        allLeagues = allLeagues.sorted { $0.league.id < $1.league.id }
        for i in 0...3 {
            localLeagues.append(allLeagues[i].league)
        }
        leagues = localLeagues
    }
}
