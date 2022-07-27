//
//  Countries.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

struct Countries: Codable {
    let response: [Country]
}
struct Country: Codable {
    let name: String?
    let code: String?
    let flag: String?
}

struct CountryModelList {
    let countries: [Country]
    init(data: Countries) {
        countries = data.response
    }
}
