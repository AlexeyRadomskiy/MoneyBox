//
//  GoalViewController.swift
//  MoneyBox
//
//  Created by Alexey on 16.04.2022.
//

import UIKit

class GoalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sortingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var addGoalButton: UIBarButtonItem!
    
    var goals: [Goal]!
    
    private var archiveGoals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои цели"
        sortingSegmentedControl.selectedSegmentIndex = 0
        sortingGoals()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "mainGoal" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let goal = goals[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let mainGoalVC = navigationVC.topViewController as! MainGoalViewController
        mainGoalVC.goal = goal
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "saveSegue" {
            sortingSegmentedControl.selectedSegmentIndex = 0
            let sourceVC = segue.source as! NewGoalTableViewController
            let goal = sourceVC.goal
            goals.append(goal)
            tableView.reloadData()
        } else if segue.identifier == "backFromMain" {
            let mainGoalVC = segue.source as! MainGoalViewController
            let goal = mainGoalVC.goal
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            goals[selectedIndexPath.row] = goal
            sortingGoals()
        } else { return }
    }
    
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension GoalViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sortingSegmentedControl.selectedSegmentIndex == 0 {
            return goals.count
        } else {
            return archiveGoals.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as! GoalTableViewCell
        if sortingSegmentedControl.selectedSegmentIndex == 0 {
            let goal = goals[indexPath.row]
            cell.set(goal: goal)
            cell.isUserInteractionEnabled = true
            
            return cell
        } else {
            let goal = archiveGoals[indexPath.row]
            cell.set(goal: goal)
            cell.isUserInteractionEnabled = false
            
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension GoalViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if sortingSegmentedControl.selectedSegmentIndex == 0 {
                goals.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                archiveGoals.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [favourite])
    }
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        if sortingSegmentedControl.selectedSegmentIndex == 0 {
            var goal = goals[indexPath.row]
            let action = UIContextualAction(style: .normal, title: nil) { action, view, completion in
                goal.isFavourite = !goal.isFavourite
                self.goals[indexPath.row] = goal
                completion(true)
            }
            action.backgroundColor = .systemOrange
            action.image = goal.isFavourite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            return action
        } else {
            var goal = archiveGoals[indexPath.row]
            let action = UIContextualAction(style: .normal, title: nil) { action, view, completion in
                goal.isFavourite = !goal.isFavourite
                self.archiveGoals[indexPath.row] = goal
                completion(true)
            }
            action.backgroundColor = .systemOrange
            action.image = goal.isFavourite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            return action
        }
    }
}

// MARK: - PrivateMethods
extension GoalViewController {
    private func sortingGoals() {
        for goal in goals {
            if goal.isDone {
                archiveGoals.append(goal)
            }
        }
        goals = goals.filter { goal in !goal.isDone}
        tableView.reloadData()
    }
}
