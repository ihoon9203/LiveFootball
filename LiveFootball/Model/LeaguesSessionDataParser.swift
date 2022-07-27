//
//  LeaguesSessionDataParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

class LeaguesSessionDataParser {
    
    func parseRequestToLeagues(request: URLRequest, onSuccess: @escaping (LeagueModelList)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(Leagues.self, from: data)
                    let leagueList = LeagueModelList(data: jsonData)
                    onSuccess(leagueList)
                }
            } catch {
                print("1")
                onFailure(error)
            }
        }
        task.resume()
    }
}
