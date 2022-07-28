//
//  FixtureSessionDataParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

class FixtureSessionDataParser {
    func parseRequestToSimpleFixtures (request: URLRequest, onSuccess: @escaping (SimpleFixtureModelList)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(FixtureAnalysis.self, from: data)
                    let simpleFixtureList = SimpleFixtureModelList(jsonData)
                    onSuccess(simpleFixtureList)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    }
    func parseRequestToPastFixtures (request: URLRequest, onSuccess: @escaping (MatchModel)->(), onFailure: @escaping (Error) -> ()) {
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
