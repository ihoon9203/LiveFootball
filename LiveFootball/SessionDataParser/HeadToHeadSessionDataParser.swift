//
//  HeadToHeadSessionDataParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation
class HeadToHeadSessionDataParser {
    func parseRequestToHeadToHead (request: URLRequest, onSuccess: @escaping (HeadToHeadModelList)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(HeadToHead.self, from: data)
                    let recordList = HeadToHeadModelList(data: jsonData)
                    onSuccess(recordList)
                }
            } catch {
                onFailure(error)
            }
        }
        task.resume()
    }
}
