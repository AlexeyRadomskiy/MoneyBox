//
//  GoalListViewController.swift
//  MoneyBox
//
//  Created by Alexey on 05.04.2022.
//

import UIKit

class GoalListViewController: UITableViewController {
    
    private var goals = Goal.getGoalList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let goal = goals[indexPath.row]
        
        content.text = goal.goalName
        content.secondaryText = "Стоимость: \(goal.income) рублей"
        content.image = UIImage(named: goal.photo)
        content.imageProperties.cornerRadius = 20
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let mainGoalVC = segue.destination as? MainGoalViewController else { return }
            mainGoalVC.goal = goals[indexPath.row]
        }
    }
}
