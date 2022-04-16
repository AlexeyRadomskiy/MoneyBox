//
//  GoalTableViewController.swift
//  MoneyBox
//
//  Created by Alexey on 16.04.2022.
//

import UIKit

class GoalTableViewController: UITableViewController {
    
    var goals = [
        Goal(name: "Кубик-рубика", photo: nil, price: "400", savings: "0", income: "10", isFavourite: false),
        Goal(name: "Машинка", photo: nil, price: "600", savings: "100", income: "10", isFavourite: false),
        Goal(name: "Наушники", photo: nil, price: "800", savings: "200", income: "10", isFavourite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои цели"
        navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Navigation
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! NewGoalTableViewController
        let goal = sourceVC.goal
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            goals[selectedIndexPath.row] = goal
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: goals.count, section: 0)
            goals.append(goal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editGoal" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let goal = goals[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let newGoalTableVC = navigationVC.topViewController as! NewGoalTableViewController
        newGoalTableVC.goal = goal
        newGoalTableVC.title = "Редактирование"
    }
}

// MARK: - UITableViewDataSource
extension GoalTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as! GoalTableViewCell
        let goal = goals[indexPath.row]
        cell.set(goal: goal)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GoalTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            goals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedGoal = goals.remove(at: sourceIndexPath.row)
        goals.insert(movedGoal, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [favourite])
    }
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var goal = goals[indexPath.row]
        let action = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            goal.isFavourite = !goal.isFavourite
            self.goals[indexPath.row] = goal
            completion(true)
        }
        action.backgroundColor = .systemOrange
        action.image = goal.isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        return action
    }
}
