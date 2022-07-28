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
    let teamSessionDataParser = TeamSessionDataParser()
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
    
    func getSpecificTeamByName(teamname: String) {
        let newTeamname = teamname.replacingOccurrences(of: " ", with: "%20")
        let teamAPIURL = Constants.baseURL+Constants.teamsEndpoint+"?"+Constants.paramTeamCode+newTeamname
        if let url = URL(string: teamAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            teamSessionDataParser.parseRequestToTeam(request: request) { team in
                print(team)
                self.delegate?.notifySpecificTeamSearched(team)
            } onFailure: { error in
                print(error)
            }
        }
    }
}
