//
//  PlayerSessionDataParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation
class PlayerSessionDataParser {
    func parseRequestToPlayerStatistic (request: URLRequest, onSuccess: @escaping (PlayerInfo)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(PlayerStatistics.self, from: data)
                    let record = PlayerInfo(data: jsonData)
                    onSuccess(record)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    }
}
