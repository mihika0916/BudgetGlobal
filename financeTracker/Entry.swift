//
//  Entry.swift
//  financeTracker
//
//  Created by Mihika Sharma on 12/04/24.
//

import UIKit

class Entry: Codable {

    var id: UUID = UUID()
    var originalVal: Double
    var value: Double
    var isIncome: Bool
    var date: Date = Date()
    var title: String
    var currency: String = "USD"
    var category: String = "None"
    var notes: String = ""
    
    init(title: String, value: Double, isIncome: Bool, date: Date = Date() ) {
        self.value = value
        self.isIncome = isIncome
        self.date = date
        self.title = title
        self.originalVal = value;
    }

    var displayValue: String {
        let sign = isIncome ? "+" : "-"
        return sign + String(format: "%.2f", abs(value)) + " " + currency
    }

}
