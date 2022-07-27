//
//  Lineups.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

struct Lineups: Codable {
    let response: [Lineup]
}
struct Lineup: Codable {
    let team: TeamInfo // from Team.swift
    let formation: String?
    let startXI: [LineupPlayer]
    let substitute: [LineupPlayer]
    let coach: Coach
}
struct LineupPlayer: Codable {
    let id: Int?
    let name: String?
    let number: Int?
    let pos: String?
}
struct Coach: Codable {
    let id: Int?
    let name: String?
    let photo: String?
}

struct LineupModelList {
    let home: Lineup
    let away: Lineup
    init(_ data: Lineups) {
        home = data.response[0]
        away = data.response[1]
    }
}
