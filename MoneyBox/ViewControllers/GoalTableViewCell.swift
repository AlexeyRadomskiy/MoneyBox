//
//  GoalTableViewCell.swift
//  MoneyBox
//
//  Created by Alexey on 16.04.2022.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var weeksLeftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        goalImage.layer.cornerRadius = 24
        nameLabel.font = UIFont.systemFont(ofSize: 17)
        progressLabel.font = UIFont.boldSystemFont(ofSize: 15)
        weeksLeftLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    func set(goal: Goal) {
        self.goalImage.image = goal.photo
        self.nameLabel.text = goal.name
        self.progressLabel.text = "Накоплено \(goal.savings) ₽ из \(goal.price) ₽"
        self.weeksLeftLabel.text = "Осталось копить недель: \((Int(goal.price)! - Int(goal.savings)!) / Int(goal.income)!)"
    }
}
