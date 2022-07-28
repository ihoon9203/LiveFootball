//
//  PredictionSessionDataParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation
class PredictionSessionDataParser {
    func parseRequestToPrediction (request: URLRequest, onSuccess: @escaping (PredictionModel)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(Prediction.self, from: data)
                    let matchList = PredictionModel(data: jsonData)
                    onSuccess(matchList)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    }
}
