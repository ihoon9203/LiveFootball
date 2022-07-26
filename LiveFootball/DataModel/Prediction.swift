//
//  Prediction.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct Prediction: Codable {
    let response: PredictionInfo
}
struct PredictionInfo: Codable {
    let predictions: Predictions
    let teams: Versus
    let comparison: Comparison
}
struct Predictions: Codable {
    let winner: Winner
    let percent: Percentage
}
struct Winner: Codable {
    let id: Int?
    let name: String?
}
struct Percentage: Codable {
    let home: String?
    let draw: String?
    let away: String?
}
struct Versus: Codable {
    let home: TeamInfo // from Teams.swift
    let away: TeamInfo
}
struct Comparison: Codable {
    let form: Percentile
    let att: Percentile
    let def: Percentile
    let goals: Percentile
    let total: Percentile
}
struct Percentile: Codable {
    let home: String?
    let away: String?
}
