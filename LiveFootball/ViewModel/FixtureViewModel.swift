//
//  APIParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

class FixtureViewModel {
    let countryParser = CountriesSessionDataParser()
    weak var delegate: FixtureCommunicationProtocol?
    func getCountryList() {
        let countryAPIURL = Constants.baseURL+Constants.countryEndpoint
        if let url = URL(string: countryAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            countryParser.parseRequestToCountries(request: request) { countries in
                print(countries)
                self.delegate?.notifyFixtureDataProvided(countries)
            } onFailure: { error in
                print(error)
            }

        }
    }
    func getLeagueList(code: String, season: Int) {
        let leagueAPIURL = Constants.baseURL+Constants.leagueEndpoint+"?"+Constants.paramCountryCode+code+"&"+Constants.paramSeason+String(season)
        if let url = URL(string: leagueAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
        }
    }
    func getTeamsData(season: Int, league: Int) {
        let teamsAPIURL = Constants.baseURL+Constants.teamsEndpoint+"?"+Constants.paramLeagueCode+String(league)+"&"+Constants.paramSeason+String(season)
        if let url = URL(string: teamsAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
        }
    }
    func getSquadData(team: Int){
        let squadAPIURL = Constants.baseURL+Constants.playerBySquadEndpoint+"?"+Constants.paramTeamCode+String(team)
        if let url = URL(string: squadAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
        }
    }
    func getFixtureData() {
        let fixtureAPIURL = Constants.baseURL+Constants.fixtureEndpoint
    }
}

