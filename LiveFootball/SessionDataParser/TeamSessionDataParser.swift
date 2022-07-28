//
//  TeamSessionDataParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation
class TeamSessionDataParser {
    func parseRequestToTeam (request: URLRequest, onSuccess: @escaping (TeamInfo)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(Teams.self, from: data)
                    let record = TeamInfo(team: jsonData.response[0])
                    onSuccess(record)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    }
    func parseRequestToTeamStatistics (request: URLRequest, onSuccess: @escaping (Team)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(Teams.self, from: data)
                    let record = TeamInfo(team: jsonData.response[0])
                    onSuccess(record)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    })
}
