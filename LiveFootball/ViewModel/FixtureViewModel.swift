//
//  APIParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

class FixtureViewModel {
    
    
    
    let countryParser = CountriesSessionDataParser()
    let leagueParser = LeaguesSessionDataParser()
    let fixtureParser = FixtureSessionDataParser()
    weak var delegate: FixtureCommunicationProtocol?
    func getCountryList() {
        let countryAPIURL = Constants.baseURL+Constants.countryEndpoint
        if let url = URL(string: countryAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            countryParser.parseRequestToCountries(request: request) { countries in
                print(countries)
                self.delegate?.notifyCountryDataProvided(countries)
            } onFailure: { error in
                print(error)
            }

        }
    }
    func getLeagueList(code: String, season: String) {
        let leagueAPIURL = Constants.baseURL+Constants.leagueEndpoint+"?"+Constants.paramCountryCode+code+"&"+Constants.paramSeason+season+"&"+"type=league"
        if let url = URL(string: leagueAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            leagueParser.parseRequestToLeagues(request: request) { leagues in
                print(leagues)
                self.delegate?.notifyLeagueDataProvided(leagues)
            } onFailure: { error in
                print(error)
            }
        }
    }
    func getTeamsData(season: Int, league: Int) {
        let teamsAPIURL = Constants.baseURL+Constants.teamsEndpoint+"?"+Constants.paramLeagueCode+String(league)+"&"+Constants.paramSeason+String(season)
        if let url = URL(string: teamsAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            leagueParser.parseRequestToLeagues(request: request) { leagues in
                print(leagues)
                self.delegate?.notifyLeagueDataProvided(leagues)
            } onFailure: { error in
                print(error)
            }
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
    func getRangedFixtureData(from: Date, range: Int, leagueCode: Int, season: String) {
        let (from, to) = ReturnRangedDate.provideRangedDate(from: from, range: range)
        let fixtureAPIURL = Constants.baseURL+Constants.fixtureEndpoint+"?"+Constants.paramDateFrom+from+"&"+Constants.paramDateTo+to+"&"+Constants.paramLeagueCode + String(leagueCode)+"&"+Constants.paramSeason+season
        if let url = URL(string: fixtureAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            fixtureParser.parseRequestToSimpleFixtures(request: request) { simpleFixtureList in
                print(simpleFixtureList)
                self.delegate?.notifySimpleFixturesProvided(simpleFixtureList)
            } onFailure: { error in
                print(error)
            }

        }
    }
}

