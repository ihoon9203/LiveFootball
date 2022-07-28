//
//  DateParser.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/28/22.
//

import Foundation

class DateParser {
    static func getYearFromDate(date: Date) -> String {
        let seasonDate = Calendar.current.date(byAdding: .year, value: -1, to: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: seasonDate!)
    }
    static func getYearFromString(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let year = dateFormatter.date(from: date) else {return "2022"}
        let seasonYear = Calendar.current.date(byAdding: .year, value: -1, to: year)
        return dateFormatter.string(from: seasonYear!)
    }
    static func getAgeFromDate(birthdate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let birthday = dateFormatter.date(from: birthdate) else { return "" }
        let ageComponents = Calendar.current.dateComponents([.year],
                                                        from: birthday,
                                                        to: Date())
        let age = ageComponents.year
        return String(age!)
    }
}
