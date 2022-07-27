//
//  LineupSessionDataParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

class LineupSessionDataParser {
    func parseRequestToLineup(request: URLRequest, onSuccess: @escaping (LineupModelList)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(Lineups.self, from: data)
                    let lineupList = LineupModelList(jsonData)
                    onSuccess(lineupList)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    }
}
