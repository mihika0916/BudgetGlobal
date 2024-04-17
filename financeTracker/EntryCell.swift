//
//  EntryCell.swift
//  financeTracker
//
//  Created by Mihika Sharma on 12/04/24.
//

import UIKit

class EntryCell: UITableViewCell {

    @IBOutlet weak var entryLabel: UILabel!
    
    @IBOutlet weak var entryValue: UILabel!
    
    @IBOutlet weak var entryDate: UILabel!
    
    func configure(with entry: Entry) {
        entryLabel.text = entry.title
        entryValue.text = entry.displayValue
        entryValue.textColor = entry.isIncome ? .systemGreen : .systemRed
        entryDate.text = formatDate(entry.date)
    }
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short // For example: Nov 23, 1937
        dateFormatter.timeStyle = .short  // For example: 3:30 PM
        return dateFormatter.string(from: date)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
