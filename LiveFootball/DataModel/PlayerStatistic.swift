//
//  PlayerStatistic.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct PlayerStatistics: Codable {
    let response: [PlayerInfo]
}
struct PlayerInfo: Codable{
    let player: Player
    let statistics: [PlayerStat]
    
    init(data: PlayerStatistics) {
        player = data.response[0].player
        statistics = data.response[0].statistics
    }
}
struct Player: Codable {
    let id: Int?
    let name: String?
    let firstname: String?
    let lastname: String?
    let height: String?
    let weight: String?
    let injured: Bool?
    let nationality: String?
    let position: String?
    let birth: Birth? // from Players.swift
    let photo: String?
}
struct PlayerStat: Codable {
    let team: TeamInfo // from Teams.swift
    let games: Game
    let shots: Shot
    let goals: Goal
    let passes: Passes
    let tackles: Tackles
    let duels: Duels
    let dribbles: Dribbles
    let fouls: Fouls
    let cards: Cards
    let penalty: Penalty
}
struct Game: Codable {
    let appearance: Int?
    let position: String?
    let rating: Double?
    let captain: Bool?
}
struct Shot: Codable {
    let total: Int?
    let on: Int?
}
struct Goal: Codable {
    let total: Int?
    let conceded: Int?
    let assists: Int?
    let saves: Int?
}
struct Passes: Codable {
    let total: Int?
    let key: Int?
    let accuracy: Int?
}
struct Tackles: Codable {
    let total: Int?
    let blocks: Int?
    let interceptions: Int?
}
struct Duels: Codable {
    let total: Int?
    let won: Int?
}
struct Dribbles: Codable {
    let attempts: Int?
    let success: Int?
    let past: Int?
}
struct Fouls: Codable {
    let drawn: Int?
    let committed: Int?
}
struct Cards: Codable {
    let yellow: Int?
    let yellowred: Int?
    let red: Int?
}
struct Penalty: Codable {
    let won: Int?
    let commited: Int?
    let scored: Int?
    let missed: Int?
    let saved: Int?
}
