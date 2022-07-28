//
//  MatchSessionDataParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation
class MatchSessionDataParser {
    func parseRequestToGeneralFixtures (request: URLRequest, onSuccess: @escaping (MatchModel)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(Match.self, from: data)
                    let matchList = MatchModel(data: jsonData)
                    onSuccess(matchList)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    }
}
