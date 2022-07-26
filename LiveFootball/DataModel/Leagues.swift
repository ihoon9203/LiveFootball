//
//  Leagues.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct Leagues: Codable {
    let response: [League]
}
struct League: Codable {
    let league: LeagueInfo
}
struct LeagueInfo: Codable {
    let id: Int
    let name: String?
    let logo: String?
}
