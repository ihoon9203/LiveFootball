//
//  HeadToHead.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct HeadToHead: Codable {
    let response: [MatchData]
}
struct MatchData: Codable {
    let fixture: FixtureHTH
    let teams: TeamsHTH
    let score: ScoreHTH
}
struct FixtureHTH: Codable {
    let date: String?
}
struct TeamsHTH: Codable {
    let home: TeamHTH
    let away: TeamHTH
}
struct TeamHTH: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let winner: Bool?
}
struct ScoreHTH: Codable {
    let fulltime: FulltimeScore
}
struct FulltimeScore: Codable {
    let home: Int?
    let away: Int?
}
