//
//  InsightsViewController.swift
//  financeTracker
//
//  Created by Mihika Sharma on 12/04/24.
//

import UIKit

class InsightsViewController: UIViewController {
    
    var week = Week.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabels()
    }
    
    @IBOutlet weak var moneyInLabel: UILabel!
    
    @IBOutlet weak var moneyOutLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var budgetRemainingLabel: UILabel!
    
    //@IBOutlet weak var budgetEmoji: UILabel!
    @IBOutlet weak var budgetEmoji: UIImageView!
    
    
    func updateLabels() {
        let totalIncome = week.entries.filter { $0.isIncome }.reduce(0.0, { $0 + $1.value })
        let totalExpense = week.entries.filter { !$0.isIncome }.reduce(0.0, { $0 + $1.value })
        let total = week.total
        let remainingBudget = week.budget - totalExpense
        
        
        
        let formattedTotalIncome = String(format: "%.2f", totalIncome)
        let formattedTotalExpense = String(format: "%.2f", totalExpense)
        let formattedTotal = String(format: "%.2f", total)
        let currencyCode = week.currency
        let formattedRemainingBudget = String(format: "%.2f", remainingBudget)
        
        // Attributed strings for different color formatting
        let incomeString = NSMutableAttributedString(string: "Money in: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        let incomeValue = NSAttributedString(string: formattedTotalIncome + " " + currencyCode, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGreen])
        incomeString.append(incomeValue)
        
        let expenseString = NSMutableAttributedString(string: "Money out: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        let expenseValue = NSAttributedString(string: formattedTotalExpense + " " + currencyCode, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        expenseString.append(expenseValue)
        
        let totalString = NSMutableAttributedString(string: "Week's total: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        let totalValue = NSAttributedString(string: formattedTotal + " " + currencyCode, attributes: [NSAttributedString.Key.foregroundColor: total >= 0 ? UIColor.systemGreen : UIColor.systemRed])
        totalString.append(totalValue)
        
        
        let budgetRemainingString = NSMutableAttributedString(string: "Budget Remaining: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        let budgetRemainingValue = NSAttributedString(string: formattedRemainingBudget + " " + currencyCode, attributes: [NSAttributedString.Key.foregroundColor: remainingBudget >= 0 ? UIColor.systemGreen : UIColor.systemRed])
        budgetRemainingString.append(budgetRemainingValue)
        
        moneyInLabel.attributedText = incomeString
        moneyOutLabel.attributedText = expenseString
        totalLabel.attributedText = totalString
        budgetRemainingLabel.attributedText = budgetRemainingString
        let symbolName = remainingBudget >= 0 ? "hand.thumbsup.fill" : "hand.thumbsdown.fill"
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium)
        budgetEmoji.image = UIImage(systemName: symbolName, withConfiguration: config)
        
    }
    
    
    
}
