//
//  CurrencyConverter.swift
//  financeTracker
//
//  Created by Mihika Sharma on 12/04/24.
//

import Foundation
class CurrencyConverter {
    var rates: [String: Double] = [:]
    
    func fetchConversionRates(completion: @escaping (Bool) -> Void) {
        let url = URL(string: "https://v6.exchangerate-api.com/v6/199ee5d8c76a58fa7d5113e1/latest/USD")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(ConversionRates.self, from: data)
                self.rates = jsonResult.conversion_rates
                completion(true)
            } catch {
                completion(false)
            }
        }
        
        task.resume()
    }
    
    func convertEntries(entries: [Entry], toCurrency targetCurrency: String) -> [Entry] {
        guard let rate = rates[targetCurrency] else { return entries }
        
        return entries.map { entry in
            var newEntry = entry
            newEntry.value = newEntry.originalVal * rate
            newEntry.currency = targetCurrency
            return newEntry
        }
    }
    

    
    // ... more methods as needed ...
}

struct ConversionRates: Codable {
    let conversion_rates: [String: Double]
}
