//
//  FixtureCommunicationProtocol.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/26/22.
//

import Foundation

protocol FixtureCommunicationProtocol: NSObject {
    func notifyFixtureDataProvided(_ countries: CountryModelList)
}
