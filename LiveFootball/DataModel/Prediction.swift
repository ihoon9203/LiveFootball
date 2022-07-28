//
//  Prediction.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct Prediction: Codable {
    let response: [PredictionInfo]
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
struct PredictionModel {
    let teams: Versus?
    let comparision: Comparison?
    let winner: Winner?
    let percentage: Percentage
    init(data: Prediction) {
        teams = data.response[0].teams
        comparision = data.response[0].comparison
        winner = data.response[0].predictions.winner
        percentage = data.response[0].predictions.percent
    }
}
