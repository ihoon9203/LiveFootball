//
//  Fixture.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

struct FixtureAnalysis: Codable {
    let response: [FixtureInfo]
}
struct FixtureInfo: Codable {
    let fixture: FixtureData?
    let league: FixtureLeagueData?
    let goals: GoalData?
    let teams: TeamsHTH?
}
struct FixtureData: Codable {
    let id: Int?
    let date: String?
    let venue: Venue?
    let status: Status?
}
struct FixtureLeagueData: Codable {
    let id: Int?
    let name: String?
    let country: String?
    let logo: String?
    let flag: String?
    let season: Int?
    let round: String?
    
}
struct GoalData: Codable {
    let home: Int?
    let away: Int?
}
struct SimpleFixtureModelList {
    let fixtures: [SimpleFixtureModel] // (date, model)
    init(_ data: FixtureAnalysis) {
        var localFixtures: [SimpleFixtureModel] = []
        for item in data.response {
            let model = SimpleFixtureModel(item)
            localFixtures.append(model)
        }
        fixtures = localFixtures
    }
}
struct SimpleFixtureModel {
    let fixtureId: Int?
    let name: String?
    let country: String?
    var homeLogo: Data = Data()
    var awayLogo: Data = Data()
    var flag: Data = Data()
    let season: Int?
    let round: String?
    let date: String?
    let goal: GoalData?
    let team: TeamsHTH?
    init(_ data: FixtureInfo) {
        fixtureId = data.fixture?.id
        name = data.league?.name
        country = data.league?.country
        season = data.league?.season
        round = data.league?.round
        date = data.fixture?.date
        goal = data.goals
        team = data.teams
        if let homeLogoURL = URL(string: data.teams?.home.logo ?? ""){
            if let homeLogoImageData = try? Data(contentsOf: homeLogoURL){
                homeLogo = homeLogoImageData
            }
        }
        if let awayLogoURL = URL(string: data.teams?.away.logo ?? ""){
            if let awayLogoImageData = try? Data(contentsOf: awayLogoURL){
                awayLogo = awayLogoImageData
            }
        }
        if let flagURL = URL(string: data.league?.flag ?? ""){
            if let flagData = try? Data(contentsOf: flagURL){
                flag = flagData
            }
        }
    }
}
