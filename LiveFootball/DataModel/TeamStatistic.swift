//
//  TeamStatistic.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/28/22.
//

import Foundation

struct TeamStatisticData: Codable {
    let response: TeamStatistic
}
struct TeamStatistic: Codable {
    let biggest: Big
    let clean_sheet: MatchGoalStatistic
    let failed_to_score: MatchGoalStatistic
    let fixtures: MatchResult
    let form: String?
    let goals: GoalStatistics
    let league: LeagueInfo
    let lineups: [SimpleLineup]
    let penalty: TeamPenalty
    let team: TeamInfo
}
struct Big: Codable {
    let goals: TeamGoal
    let loses: GoalData
    let streak: Streak
    let win: Win
}
struct TeamGoal: Codable {
    let against: GoalData
    let `for`: GoalData
}
struct Streak: Codable {
    let draws: Int?
    let loses: Int?
    let wins: Int?
}
struct Win: Codable {
    let away: String?
    let home: String?
}
struct MatchGoalStatistic: Codable {
    let away: Int?
    let home: Int?
    let total: Int?
}
struct MatchResult: Codable {
    let draws: MatchGoalStatistic
    let loses: MatchGoalStatistic
    let palyed: MatchGoalStatistic
    let wins: MatchGoalStatistic
}
struct GoalStatistics: Codable {
    let against: MatchGoalStatContainer
    let `for`: MatchGoalStatContainer
}
struct MatchGoalStatContainer: Codable {
    let average: MatchGoalStatistic
    let total: MatchGoalStatistic
}
struct SimpleLineup: Codable {
    let formation: String?
    let played: Int?
}
struct TeamPenalty: Codable {
    let missed: PenaltyPercentage
    let scored: PenaltyPercentage
}
struct PenaltyPercentage: Codable {
    let percentage: String?
    let total: Int?
}
