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
    func parseRequestToPastFixtures (request: URLRequest, onSuccess: @escaping (PreviousMatchModelList)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(PreviousMatch.self, from: data)
                    let matchList = PreviousMatchModelList(data: jsonData)
                    onSuccess(matchList)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    }
    func parseRequestToCurrentFixtures (request: URLRequest, onSuccess: @escaping (OnGoingMatchModelList)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(OnGoingMatch.self, from: data)
                    let matchList = OnGoingMatchModelList(data: jsonData)
                    onSuccess(matchList)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    }
    func parseRequestToFutureFixtures (request: URLRequest, onSuccess: @escaping (FutureMatchModelList)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(FutureMatch.self, from: data)
                    let matchList = FutureMatchModelList(data: jsonData)
                    onSuccess(matchList)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    }
}
