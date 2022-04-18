//
//  MainGoalViewController.swift
//  MoneyBox
//
//  Created by Alexey on 16.04.2022.
//

import UIKit

class MainGoalViewController: UIViewController {
    
    var goal = Goal(name: "",
                    photo: nil,
                    price: "",
                    savings: "",
                    income: "",
                    isFavourite: false,
                    isDone: false)
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weeksLeftLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Navigation
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveEditSegue" else { return }
        let editGoalVC = segue.source as! EditGoalTableViewController
        let goal = editGoalVC.goal
        
        self.goal = goal
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editGoal" else { return }
        let editGoalVC = segue.destination as! EditGoalTableViewController
        editGoalVC.goal = goal
    }
    
    @IBAction func toggleFavorite(_ sender: UIButton) {
        goal.isFavourite.toggle()
        setStatusForFavouriteButton()
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Убавить средства",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "\(self.goal.income)"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(UIAlertAction(title: "Убавить", style: .default, handler: { _ in
            let textField = alertController.textFields![0] as UITextField
            let amount = Int(textField.text!) ?? 0
            self.calculate(amount: -amount)
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Добавить средства",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "\(self.goal.income)"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { _ in
            let textField = alertController.textFields![0] as UITextField
            let amount = Int(textField.text!) ?? 0
            self.calculate(amount: amount)
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func shareGoal(_ sender: Any) {
        let shareController = UIActivityViewController(activityItems: [goal.name, goal.price], applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                print("done")
            }
        }
        
        present(shareController, animated: true)
    }
}

// MARK: - Private methods
extension MainGoalViewController {
    private func updateUI() {
        photoImage.image = goal.photo
        setStatusForFavouriteButton()
        nameLabel.text = goal.name
        weeksLeftLabel.text = "Осталось копить \nнедель: \((Int(goal.price)! - Int(goal.savings)!) / Int(goal.income)!)"
        progressLabel.text = "Накоплено \(goal.savings) ₽ \nиз \(goal.price) ₽ "
    }
    
    private func setStatusForFavouriteButton() {
        let image = goal.isFavourite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favouriteButton.setImage(image, for: .normal)
    }
    
    private func calculate(amount: Int) {
        if amount == 0 { return }
        goal.savings = "\(Int(goal.savings)! + amount)"
        if Int(goal.savings)! >= Int(goal.price)! {
            goal.isDone = true
            congrats()
        }
        updateUI()
    }
    
    private func congrats() {
        let alert = UIAlertController(title: "🥳 П О З Д Р А В Л Я Ю 🥳",
                                      message: "Вы накопили на цель: \(goal.name)",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "У Р А !", style: .default)
        
        alert.addAction(okAction)
        goal.savings = goal.price
        present(alert, animated: true)
    }
}
