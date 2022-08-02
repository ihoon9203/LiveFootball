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

struct StandingModelList {
    var teams: [TeamWithStandingModel] = []
    init(_ data: Standing) {
        var localTeams = [TeamWithStandingModel]()
        let allStanding = data.response[0].league.standings[0]
        
        for item in allStanding {
            let team = TeamWithStandingModel(item)
            localTeams.append(team)
        }
        teams = localTeams
    }
}
struct TeamWithStandingModel {
    let rank: Int?
    let played: Int?
    let win: Int?
    let draw: Int?
    let goals: Int?
    let goalsAgainst: Int?
    let teamInfo: TeamModel
    init(_ data: Stand) {
        rank = data.rank
        played = data.all.played
        win = data.all.win
        draw = data.all.draw
        goals = data.all.goals?.`for`
        goalsAgainst = data.all.goals?.against
        teamInfo = TeamModel(data.team)
    }
}
struct TeamModel {
    let id: Int?
    let name: String?
    var logo: Data = Data()
    init(_ data: TeamInfo) {
        id = data.id
        name = data.name
        if let imageURL = URL(string: data.logo ?? "") {
            if let imageData = try? Data(contentsOf: imageURL){
                logo = imageData
            }
        }
    }
}
