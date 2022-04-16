//
//  MainGoalViewController.swift
//  MoneyBox
//
//  Created by Alexey on 16.04.2022.
//

import UIKit

class MainGoalViewController: UIViewController {
    
    var goal = Goal(name: "", photo: nil, price: "", savings: "", income: "", isFavourite: false)

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var isFavouriteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weeksLeftLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        guard segue.identifier == "mainGoal" else { return }
//        let indexPath = tableView.indexPathForSelectedRow!
//        let goal = goals[indexPath.row]
//        let navigationVC = segue.destination as! UINavigationController
//        let newGoalTableVC = navigationVC.topViewController as! NewGoalTableViewController
//        newGoalTableVC.goal = goal
//        newGoalTableVC.title = "Редактирование"
//    }
    
    @IBAction func minusButton(_ sender: UIButton) {
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
    }
}

// MARK: - Private methods
extension MainGoalViewController {
    private func updateUI() {
        photoImage.image = goal.photo
        nameLabel.text = goal.name
        weeksLeftLabel.text = "Осталось \((Int(goal.price)! - Int(goal.savings)!) / Int(goal.income)!) недель"
        progressLabel.text = "Накоплено \(goal.income) ₽ из \(goal.price) ₽"
    }
}
