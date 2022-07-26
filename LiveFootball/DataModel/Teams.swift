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
}
struct Venue: Codable {
    let name: String?
}
