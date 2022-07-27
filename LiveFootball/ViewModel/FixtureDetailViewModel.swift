//
//  FixtureDetailViewModel.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

class FixtureDetailViewModel {
    let lineupSessionDataParser = LineupSessionDataParser()
    
    weak var delegate: FixtureDetailCommunicationProtocol?
    func getLineupList(_ fixtureCode: Int) {
        let lineupAPIURL = Constants.baseURL+Constants.lineupEndpoint+"?"+Constants.paramFixtureID+String(fixtureCode)
        if let url = URL(string: lineupAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            lineupSessionDataParser.parseRequestToLineup(request: request) { lineup in
                print(lineup)
                self.delegate?.notifyLineupDataProvided(lineup)
            } onFailure: { error in
                print(error)
            }

        }
    }
    func getMatchData(_ fixtureCode: Int) {
        let lineupAPIURL = Constants.baseURL+Constants.lineupEndpoint+"?"+Constants.paramFixtureID+String(fixtureCode)
        if let url = URL(string: lineupAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            lineupSessionDataParser.parseRequestToLineup(request: request) { lineup in
                print(lineup)
                self.delegate?.notifyFixtureDataProvided(lineup)
            } onFailure: { error in
                print(error)
            }

        }
    }
}

