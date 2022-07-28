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
struct HeadToHeadModelList {
    let records: [HeadToHeadModel]
    
    init(data: HeadToHead) {
        var localRecords: [HeadToHeadModel] = []
        for record in data.response {
            localRecords.append(HeadToHeadModel(data: record))
        }
        records = localRecords
    }
}
struct HeadToHeadModel {
    let date: String?
    let home: TeamHTH
    let away: TeamHTH
    let score: FulltimeScore
    init(data: MatchData) {
        date = data.fixture.date
        home = data.teams.home
        away = data.teams.away
        score = data.score.fulltime
    }
}
