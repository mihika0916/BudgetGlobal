//
//  ViewController.swift
//  financeTracker
//
//  Created by Mihika Sharma on 12/04/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    var currentWeek = Week.shared
    var converter = CurrencyConverter()
    var currentCurrency: String = "USD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TotalCell")
        entryTableView.dataSource = self
        entryTableView.reloadData()
        updateNoEntriesLabelVisibility()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentWeek.loadEntries() // Load the updated entries from local storage
        entryTableView.reloadData()
    }
    
    
    
    
    @IBAction func setBudgetButtonClicked(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Set Budget", message: "Enter your weekly budget", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter budget"
            textField.keyboardType = .decimalPad
        }
        
        let confirmAction = UIAlertAction(title: "Set", style: .default) { [weak self, weak alertController] _ in
            guard let textField = alertController?.textFields?.first, let text = textField.text, let budget = Double(text) else {
                return
            }
            
            self?.currentWeek.budget = budget
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var noEntriesLabel: UILabel!
    func updateNoEntriesLabelVisibility() {
        noEntriesLabel.isHidden = !currentWeek.entries.isEmpty
    }
    
    
    @IBOutlet weak var entryTableView: UITableView!
    
    
    @IBAction func clearButtonClicked(_ sender: Any) {
        guard !currentWeek.entries.isEmpty else { return }
        currentWeek.clearAllEntries()   // Clear all entries from the current week
        entryTableView.reloadData()     // Reload table view to reflect the empty state
        updateNoEntriesLabelVisibility()
        
        
    }
    
    
    
    
    
    
    @IBOutlet weak var addEntryButton: UIButton!
    
    @IBAction func addEntryButtonClicked(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Type of Entry", message: "Select the type of entry you want to add", preferredStyle: .actionSheet)
        
        let incomeAction = UIAlertAction(title: "Income", style: .default) { [weak self] _ in
            self?.presentEntryAlert(isIncome: true)
        }
        let expenseAction = UIAlertAction(title: "Expense", style: .default) { [weak self] _ in
            self?.presentEntryAlert(isIncome: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(incomeAction)
        actionSheet.addAction(expenseAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
        
    }
    
    
    func presentEntryAlert(isIncome: Bool) {
        let title = isIncome ? "Add Income" : "Add Expense"
        let alert = UIAlertController(title: title, message: "Enter the details", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Title"
        }
        alert.addTextField { textField in
            textField.placeholder = "Value"
            textField.keyboardType = .decimalPad
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let title = alert.textFields?.first?.text,
                  let valueString = alert.textFields?.last?.text,
                  let value = Double(valueString) else { return }
            
            let entry = Entry(title: title, value: value, isIncome: isIncome)
            self?.currentWeek.addEntry(entry)
            self?.entryTableView.reloadData()
            self?.updateNoEntriesLabelVisibility()
        }
        
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    
    
    
    @IBAction func changeCurrencyButtonClicked(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Select Currency", message: "Choose a currency", preferredStyle: .actionSheet)
        
        
        ["USD", "EUR", "GBP", "JPY", "AUD"].forEach { currencyCode in
            actionSheet.addAction(UIAlertAction(title: currencyCode, style: .default, handler: { _ in
                self.applyCurrencyConversion(to: currencyCode)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }
    
    func applyCurrencyConversion(to currency: String) {
        converter.fetchConversionRates { success in
            DispatchQueue.main.async {
                if success {
                    self.currentWeek.entries = self.converter.convertEntries(entries: self.currentWeek.entries, toCurrency: currency)
                    self.entryTableView.reloadData()
                    self.currentWeek.saveEntries()
                    self.currentWeek.currency = currency
                    self.currentWeek.calculateTotal()
                } else {
                    // Handle the error
                }
            }
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailEntry", let detailVC = segue.destination as? detailEntryViewController, let indexPath = entryTableView.indexPathForSelectedRow {
            detailVC.entry = currentWeek.entries[indexPath.row]
        }
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentWeek.entries.count  // All entries go here
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryCell else {
            fatalError("Cell not found")
        }
        let entry = currentWeek.entries[indexPath.row]
        cell.configure(with: entry)
        // Further customize the cell...
        return cell
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentWeek.deleteEntry(at: indexPath.row)
            // Delete the corresponding row from the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateNoEntriesLabelVisibility()
        }
    }
    
    
    
    
    
    
    
    
    
}

