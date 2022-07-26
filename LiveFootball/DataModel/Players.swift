//
//  Players.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct Players: Codable {
    let response: [Squad] // only use first item
}
struct Squad: Codable {
    let team: TeamInfo // from Teams.swift
    let players: [PlayerSquadInfo]
}
struct PlayerSquadInfo: Codable {
    let id: Int?
    let name: String?
    let age: Int?
    let number: Int?
    let photo: String?
}
struct Birth: Codable {
    let date: String?
}
