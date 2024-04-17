//
//  detailEntryViewController.swift
//  financeTracker
//
//  Created by Mihika Sharma on 16/04/24.
//

import UIKit

class detailEntryViewController: UIViewController {
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEntryDetails()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var entryNameLabel: UILabel!
    
    @IBOutlet weak var entryNameText: UITextField!
    
    @IBOutlet weak var entryCostLabel: UILabel!
    
    @IBOutlet weak var entryCostText: UITextField!
    
    @IBOutlet weak var entryNotes: UILabel!
    
    @IBOutlet weak var entryNotesText: UITextField!
    
    
    @IBOutlet weak var entryCategory: UILabel!
    
    @IBOutlet weak var entryCategoryText: UITextField!
    
    @IBOutlet weak var entryDate: UILabel!
    
    
    
    @IBAction func editEntryButton(_ sender: Any) {
        
        guard let entry = entry,
              let name = entryNameText.text, !name.isEmpty,
              let valueText = entryCostText.text, let value = Double(valueText),
              let notes = entryNotesText.text,
              let category = entryCategoryText.text else {return}
        // Handle validation failure: alert the user to fill in all information
        entry.title = name
        entry.value = value
        entry.notes = notes
        entry.category = category
        saveEntry(entry)
        
    }
    private func saveEntry(_ entry: Entry) {
        // Find the entry in the Week data model and update it
        if let index = Week.shared.entries.firstIndex(where: { $0.id == entry.id }) {
            Week.shared.entries[index] = entry
            Week.shared.saveEntries()
            Week.shared.loadEntries()
        }
        Week.shared.calculateTotal()
        
        navigationController?.popViewController(animated: true)
    }
    
    private func loadEntryDetails() {
        entryNameText.text = entry?.title
        entryCostText.text = "\(entry?.value ?? 0)"
        entryNotesText.text = entry?.notes
        entryCategoryText.text = entry?.category
        entryDate.text = entry?.date.formatted()
        
    }
    
    
    
    
    
}
