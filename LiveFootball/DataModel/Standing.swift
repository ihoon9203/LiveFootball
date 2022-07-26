//
//  Standing.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct Standing: Codable {
    let response: [ResultingLeague]
}
struct ResultingLeague: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let country: String?
    let flag: String?
    let league: LeagueData
}
struct LeagueData: Codable {
    let standings: [[Stand]]
}
struct Stand: Codable {
    let rank: Int?
    let team: TeamInfo
    let all: All
}
struct All: Codable {
    let played: Int?
    let win: Int?
    let draw: Int?
    let lose: Int?
    let goals: Goals?
}
struct Goals: Codable {
    let `for` : Int?
    let against: Int?
}
