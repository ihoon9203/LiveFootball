//
//  CountriesSessionDataParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

class CountriesSessionDataParser {
    
    func parseRequestToCountries(request: URLRequest, onSuccess: @escaping ([Country])->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let countryList = try JSONDecoder().decode(Countries.self, from: data)
                    onSuccess(countryList.response)
                }
            } catch {
                print("1")
                onFailure(error)
            }
        }
        task.resume()
    }
}
