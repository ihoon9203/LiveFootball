//
//  Teams.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct Teams: Codable {
    let response: [Team]
}
struct Team: Codable {
    let team: TeamInfo
    let venue: Venue
}
struct TeamInfo: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    init(team: Team) {
        id = team.team.id
        name = team.team.name
        logo = team.team.logo
    }
}
struct Venue: Codable {
    let name: String?
}
//struct TeamModel {
//    init(data: Team) {
//        var localTeams = [TeamModel]()
//        for team in data.response {
//            let team = TeamModel(team)
//        }
//        teams = localTeams
//    }
//}
