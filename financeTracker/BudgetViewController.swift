//
//  BudgetViewController.swift
//  financeTracker
//
//  Created by Mihika Sharma on 12/04/24.
//

import UIKit

class BudgetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeek.loadEntries()
        setupTableView()

        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
//            tableView.dataSource = self
        }
    
    
    
    var currentWeek = Week()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentWeek.entries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
        let entry = currentWeek.entries[indexPath.row]
        cell.textLabel?.text = entry.displayValue
        // Further customize the cell...
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
