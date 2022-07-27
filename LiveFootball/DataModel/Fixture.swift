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
    let goal: GoalData?
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
        for item in data.response {
            let model = SimpleFixtureModel(item)
            fixtures.append(model)
        }
    }
}
struct SimpleFixtureModel {
    let fixtureId: Int?
    let name: String?
    let country: String?
    let logo: String?
    let flag: String?
    let season: Int?
    let round: String?
    let date: String?
    let goal: GoalData?
    let team: TeamsHTH?
    init(_ data: FixtureInfo) {
        fixtureId = data.fixture?.id
        name = data.league?.name
        country = data.league?.country
        logo = data.league?.logo
        flag = data.league?.flag
        season = data.league?.season
        round = data.league?.round
        date = data.fixture?.date
        goal = data.goal
        team = data.teams
    }
}
