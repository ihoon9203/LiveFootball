//
//  FixtureDetailViewModel.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

class FixtureDetailViewModel {
    let lineupSessionDataParser = LineupSessionDataParser()
    let matchSessionDataParser = MatchSessionDataParser()
    let predictionSessionDataParser = PredictionSessionDataParser()
    let headToHeadSessionDataParser = HeadToHeadSessionDataParser()
    
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
        let matchAPIURL = Constants.baseURL+Constants.fixtureEndpoint+"?"+Constants.paramFixtureID+String(fixtureCode)
        if let url = URL(string: matchAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            matchSessionDataParser.parseRequestToGeneralFixtures(request: request) { matchModel in
                self.delegate?.notifyFixtureDataProvided(matchModel)
            } onFailure: { error in
                print(error)
            }
        }
    }
    func getPredictionData(_ fixtureCode: Int) {
        let predictionAPIURL = Constants.baseURL+Constants.predictionEndpoint+"?"+Constants.paramFixtureID+String(fixtureCode)
        if let url = URL(string: predictionAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            predictionSessionDataParser.parseRequestToPrediction(request: request) { predictionModel in
                self.delegate?.notifyPredicitonDataProvided(predictionModel)
            } onFailure: { error in
                print(error)
            }
        }
    }
    func getHeadToHeadData(homeCode: Int, awayCode: Int) {
        let headtoheadAPIURL = Constants.baseURL+Constants.hthEndpoint+"?"+Constants.paramHTH+"\(homeCode)-\(awayCode)"+"&"+Constants.paramLast+Constants.matchesToShow
        if let url = URL(string: headtoheadAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            headToHeadSessionDataParser.parseRequestToHeadToHead(request: request) { headtoheadModelList in
                self.delegate?.notifyHTHDataProvided(headtoheadModelList)
            } onFailure: { error in
                print(error)
            }
        }
    }
}

