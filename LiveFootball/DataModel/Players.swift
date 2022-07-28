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
struct PlayerCoreDataInfo {
    let id: Int?
    let name: String?
    var photo: Data = Data()
    init(info: PlayerSquadInfo) { // from Players.swift
        id = info.id
        name = info.name
        if let imageURL = URL(string: info.photo ?? "") {
            if let imageData = try? Data(contentsOf: imageURL){
                photo = imageData
            }
        }
    }
    init(info: Player) { // from PlayerStatistic.swift
        id = info.id
        name = info.name
        if let imageURL = URL(string: info.photo ?? "") {
            if let imageData = try? Data(contentsOf: imageURL){
                photo = imageData
            }
        }
    }
}
