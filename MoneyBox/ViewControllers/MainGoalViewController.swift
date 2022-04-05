//
//  MainGoalViewController.swift
//  MoneyBox
//
//  Created by Alexey on 05.04.2022.
//

import UIKit

class MainGoalViewController: UIViewController {
    
    @IBOutlet var photoLabel: UIImageView!
    @IBOutlet var goalNameLabel: UILabel!
    @IBOutlet var weeksLeftLabel: UILabel!
    @IBOutlet var progressLabel: UILabel!
    
    
    var goal: Goal!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Моя цель"
        photoLabel.image = UIImage(named: goal.photo)
        goalNameLabel.text = "Цель: \(goal.goalName)"
        weeksLeftLabel.text = "Осталось копить еще \((goal.price - goal.savings) / (goal.income)) недель"
        progressLabel.text = "Накоплено \(goal.savings) из \(goal.price) рублей"
    }
    
    @IBAction func deductionMoneyButton() {
    }
    
    @IBAction func addingMoneyButton() {
    }
}
