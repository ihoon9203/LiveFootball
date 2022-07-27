//
//  ReturnRangedDate.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

class ReturnRangedDate {
    static func provideRangedDate(_ range: Int) -> (String, String) {
        let from = Calendar.current.date(byAdding: .day, value: -1 * range, to: Date()) ?? Date()
        let to = Calendar.current.date(byAdding: .day, value: range, to: Date()) ?? Date()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return (dateFormatter.string(from: from), dateFormatter.string(from: to))
    }
}
