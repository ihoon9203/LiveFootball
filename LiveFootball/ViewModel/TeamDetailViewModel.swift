//
//  TeamDetailViewModel.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 8/2/22.
//

import Foundation

class TeamDetailViewModel {
    weak var delegate: TeamCommunicationProtocol?
    let teamSessionDataParser = TeamSessionDataParser()
    let fixtureSessionDataParser = FixtureSessionDataParser()
    
    func getTotalTeamData(leagueCode: Int, teamCode: Int, season: Int) {
        let teamStatisticAPIURL = Constants.baseURL+Constants.teamStatisticsEndpoint+"?"+Constants.paramLeagueCode+String(leagueCode)+"&"+Constants.paramSeason+String(season)+"&"+Constants.paramTeamCode+String(teamCode)
        let fixtureDataAPIURL = Constants.baseURL+Constants.fixtureEndpoint+"?"+Constants.paramLeagueCode + String(leagueCode)+"&"+Constants.paramSeason+String(season)+"&"+Constants.paramTeamCode+String(teamCode)
        if let url = URL(string: teamStatisticAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            teamSessionDataParser.parseRequestToTeamStatistics(request: request) { statData in
                self.delegate?.notifyTeamStatisticDataProvided(statData)
            } onFailure: { error in
                print(error)
            }
        }
        if let urlfixture = URL(string: fixtureDataAPIURL) {
            var request = URLRequest(url: urlfixture)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            fixtureSessionDataParser.parseRequestToSimpleFixtures(request: request) { fixtureData in
                self.delegate?.notifyNextFixtureDataProvided(fixtureData)
            } onFailure: { error in
                print(error)
            }
        }
    }
}
