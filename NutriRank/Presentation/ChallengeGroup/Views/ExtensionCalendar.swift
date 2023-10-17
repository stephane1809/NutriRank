//
//  ExtensionCalendar.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 17/10/23.
//

import Foundation

extension Calendar {
    func numberOfDaysBetween(start from: Date, end to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>

        return numberOfDays.day!
    }
}
