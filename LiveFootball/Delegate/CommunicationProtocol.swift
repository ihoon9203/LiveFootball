//
//  CommunicationProtocol.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

protocol FixtureCommunicationProtocol: NSObject {
    func notifyCountryDataProvided(_ countries: CountryModelList)
    func notifyLeagueDataProvided(_ leagues: LeagueModelList)
    func notifySimpleFixturesProvided(_ fixtures: SimpleFixtureModelList)
}

protocol FixtureDetailCommunicationProtocol: NSObject {
    func notifyLineupDataProvided(_ lineup: LineupModelList)
    func notifyFixtureDataProvided(_ fixture: MatchModel)
    func notifyPredicitonDataProvided(_ prediction: PredictionModel)
    func notifyHTHDataProvided(_ records: HeadToHeadModelList)
}

protocol PlayerCommunicationProtocol: NSObject {
    func notifyPlayerDataProvided(_ player: PlayerInfo)
}

protocol LeagueCommunicationProtocol: NSObject {
    func notifyLeagueDataProvided(_ league: LeagueModelList)
    func notifyStandingDataProvided(_ standing: StandingModelList)
    func notifySpecificTeamSearched(_ team: TeamInfo)
}

protocol TeamCommunicationProtocol: NSObject {
    func notifyTeamStatisticDataProvided(_ teamStat: TeamStat)
}
