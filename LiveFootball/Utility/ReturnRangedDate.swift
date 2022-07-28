//
//  ReturnRangedDate.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/27/22.
//

import Foundation

class ReturnRangedDate {
    static func provideRangedDate(from: Date, range: Int) -> (String, String) {
        let from = Calendar.current.date(byAdding: .day, value: -1 * range, to: from) ?? Date()
        let to = Calendar.current.date(byAdding: .day, value: range, to: from) ?? Date()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return (dateFormatter.string(from: from), dateFormatter.string(from: to))
    }
}
