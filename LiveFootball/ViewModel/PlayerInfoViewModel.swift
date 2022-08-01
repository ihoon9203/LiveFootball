//
//  PlayerInfoViewModel.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

class PlayerInfoViewModel {
    weak var delegate: PlayerCommunicationProtocol?
    let playerSessionDataParser = PlayerSessionDataParser()
    
    func getPlayerInfoData(playerCode: Int, seasonCode: String) {
        let lineupAPIURL = Constants.baseURL+Constants.playersEndpoint+"?"+Constants.paramPlayerID+String(playerCode)+"&"+Constants.paramSeason+seasonCode
        if let url = URL(string: lineupAPIURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: Constants.apiKey)
            request.httpMethod = "GET"
            
            playerSessionDataParser.parseRequestToPlayerStatistic(request: request) { playerInfo in
                self.delegate?.notifyPlayerDataProvided(playerInfo)
            } onFailure: { error in
                print(error)
            }

        }
    }
}
