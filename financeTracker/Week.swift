//
//  Week.swift
//  financeTracker
//
//  Created by Mihika Sharma on 12/04/24.
//

import Foundation

class Week {
    var entries: [Entry] = []
    static let shared = Week() 

    var total: Double = 0.0
    var currency : String = "USD"
    var budget : Double = 10000
    
    init() {
        
        loadEntries()// Load entries when the Week object is initialized
        calculateTotal()
        //print(self.total)
    }

    func addEntry(_ entry: Entry) {
        entries.append(entry)
        saveEntries()
        calculateTotal()
    }
    
    func deleteEntry(at index: Int) {
        entries.remove(at: index)
        saveEntries()
        calculateTotal()
    }
    func calculateTotal() {
        self.total = entries.reduce(0.0) { $0 + ($1.isIncome ? $1.value : -$1.value) }
        print("now total is : " + String(self.total))
    }
    
    func clearAllEntries() {
        entries.removeAll()
        calculateTotal()  // Recalculate the total after clearing entries
        saveEntries()     // Save the empty state to UserDefaults
    }
    
    // Add methods for saving and loading from UserDefaults here...
}

extension Week {
    private static let entriesKey = "weekEntries"

    func saveEntries() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(entries) {
            UserDefaults.standard.set(encoded, forKey: Week.entriesKey)
        }
    }

    func loadEntries() {
        let decoder = JSONDecoder()
        if let savedEntries = UserDefaults.standard.object(forKey: Week.entriesKey) as? Data,
           let loadedEntries = try? decoder.decode([Entry].self, from: savedEntries) {
            entries = loadedEntries
        }
    }
    
    
    var totalFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current // Or .autoupdatingCurrent
        return formatter.string(from: NSNumber(value: self.total)) ?? "\(total)"
    }
}

