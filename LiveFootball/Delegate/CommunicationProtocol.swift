//
//  FixtureCommunicationProtocol.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

protocol FixtureCommunicationProtocol: NSObject {
    func notifyCountryDataProvided(_ countries: CountryModelList)
    func notifyLeagueDataProvided(_ leagues: LeagueModelList)
    func notifyStandingDataProvided(_ standing: StandingModelList)
}
