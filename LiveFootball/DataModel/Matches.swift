//
//  Matches.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct Match: Codable {
    let response: MatchInfo
}
struct MatchInfo: Codable {
    let fixture: CurrentFixture
    let teams: MatchTeamsInfo
    let league: LeagueInfo
    let goals: MatchGoal
}

struct Fixture: Codable {
    let id: Int?
    let date: String?
    let venue: Venue? // from Teams.swift
}

struct CurrentFixture: Codable {
    let id: Int?
    let date: String?
    let venue: Venue? // from Teams.swift
    let status: Status?
}
struct Status: Codable {
    let elapsed: Int?
}

struct MatchTeamsInfo: Codable {
    let home: TeamInfo? // from Teams.swift
    let away: TeamInfo?
}

struct Score: Codable {
    let fulltime: FullTime
}
struct FullTime: Codable {
    let home: Int?
    let away: Int?
}

struct MatchGoal: Codable {
    let home: Int?
    let away: Int?
}

struct MatchModel {
    let home: String?
    let away: String?
    let homeID: Int?
    let awayID: Int?
    let homeLogo: String?
    let awayLogo: String?
    let homeScore: Int?
    let awayScore: Int?
    let stadium: String?
    let date: String?
    let elapsed: Int?
    let fixtureID: Int?
    init(data: Match) {
        home = data.response.teams.home?.name
        away = data.response.teams.away?.name
        homeID = data.response.teams.home?.id
        awayID = data.response.teams.away?.id
        homeLogo = data.response.teams.home?.logo
        awayLogo = data.response.teams.away?.logo
        homeScore = data.response.goals.home
        awayScore = data.response.goals.away
        stadium = data.response.fixture.venue?.name
        date = data.response.fixture.date
        elapsed = data.response.fixture.status?.elapsed
        fixtureID = data.response.fixture.id
    }
}
