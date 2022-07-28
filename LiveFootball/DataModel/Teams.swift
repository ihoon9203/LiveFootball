//
//  Teams.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct Teams: Codable {
    let response: [Team]
}
struct Team: Codable {
    let team: TeamInfo
    let venue: Venue
}
struct TeamInfo: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    init(team: Team) {
        id = team.team.id
        name = team.team.name
        logo = team.team.logo
    }
}
struct Venue: Codable {
    let name: String?
}
struct TeamCoreDataInfo {
    let id: Int?
    let name: String?
    var logo: Data = Data()
    init(info: TeamInfo) {
        id = info.id
        name = info.name
        if let imageURL = URL(string: info.logo ?? "") {
            if let imageData = try? Data(contentsOf: imageURL){
                logo = imageData
            }
        }
    }
}
