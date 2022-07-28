//
//  LeagueViewModel.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

class LeagueViewModel {
    weak var delegate: LeagueCommunicationProtocol?
    let leaguesSessionDataParser = LeaguesSessionDataParser()
    let standingSessionDataParser = StandingsSessionDataParser()
    func getLeagueList(code: String, season: Int) {
        let leagueAPIURL = Constants.baseURL+Constants.leagueEndpoint+"?"+Constants.paramCountryCode+code+"&"+Constants.paramSeason+String(season)
        if let url = URL(string: leagueAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            leaguesSessionDataParser.parseRequestToLeagues(request: request) { leagues in
                print(leagues)
                self.delegate?.notifyLeagueDataProvided(leagues)
            } onFailure: { error in
                print(error)
            }
        }
    }
    
    func getStandingList(leagueCode: Int, season: Int) {
        let standingAPIURL = Constants.baseURL+Constants.standingEndpoint+"?"+Constants.paramLeagueCode+String(leagueCode)+"&"+Constants.paramSeason+String(season)
        if let url = URL(string: standingAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            standingSessionDataParser.parseRequestToStanding(request: request) { teams in
                print(teams)
                self.delegate?.notifyStandingDataProvided(teams)
            } onFailure: { error in
                print(error)
            }
        }
    }
}
