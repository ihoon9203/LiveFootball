//
//  Matches.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct PreviousMatch: Codable {
    let response: PreviousMatchInfo
}

struct PreviousMatchInfo: Codable {
    let fixture: Fixture
    let teams: MatchTeamsInfo
    let league: LeagueInfo
    let score: Score
}

struct OnGoingMatch: Codable {
    let response: OnGoingMatchInfo
}
struct OnGoingMatchInfo: Codable {
    let fixture: CurrentFixture
    let teams: MatchTeamsInfo
    let league: LeagueInfo
    let goals: MatchGoal
}

struct FutureMatch: Codable {
    let response: FutureMatchInfo
}
struct FutureMatchInfo: Codable {
    let fixture: Fixture
    let teams: MatchTeamsInfo
    let league: LeagueInfo
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
