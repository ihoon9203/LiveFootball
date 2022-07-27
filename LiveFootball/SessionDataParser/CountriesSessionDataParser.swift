//
//  CountriesSessionDataParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

class CountriesSessionDataParser {
    
    func parseRequestToCountries(request: URLRequest, onSuccess: @escaping (CountryModelList)->(), onFailure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let jsonData = try JSONDecoder().decode(Countries.self, from: data)
                    let countryList = CountryModelList(data: jsonData)
                    onSuccess(countryList)
                }
            } catch {
                print("1")
                onFailure(error)
            }
        }
        task.resume()
    }
}
