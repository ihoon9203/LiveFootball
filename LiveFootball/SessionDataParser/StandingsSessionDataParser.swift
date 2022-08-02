//
//  TeamsSessionDataParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

class StandingsSessionDataParser {
    func parseRequestToStanding(request: URLRequest, onSuccess: @escaping (StandingModelList)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(Standing.self, from: data)
                    let teamList = StandingModelList(jsonData)
                    onSuccess(teamList)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    }
}
