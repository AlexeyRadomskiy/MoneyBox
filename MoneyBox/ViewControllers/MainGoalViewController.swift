//
//  MainGoalViewController.swift
//  MoneyBox
//
//  Created by Alexey on 16.04.2022.
//

import UIKit

class MainGoalViewController: UIViewController {
    
    var goal = Goal(name: "", photo: nil, price: "", savings: "", income: "", isFavourite: false, isDone: false)

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
        let alertController = UIAlertController(title: "Убавить средства", message: nil, preferredStyle: .alert)
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
        let alertController = UIAlertController(title: "Добавить средства", message: nil, preferredStyle: .alert)
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
}

// MARK: - Private methods
extension MainGoalViewController {
    private func updateUI() {
        photoImage.image = goal.photo
        setStatusForFavouriteButton()
        nameLabel.text = goal.name
        weeksLeftLabel.text = "Осталось \((Int(goal.price)! - Int(goal.savings)!) / Int(goal.income)!) недель"
        progressLabel.text = "Накоплено \(goal.savings) ₽ из \(goal.price) ₽"
    }
    
    private func setStatusForFavouriteButton() {
        let image = goal.isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favouriteButton.setImage(image, for: .normal)
    }
    
    private func calculate(amount: Int) {
        if amount == 0 { return }
        goal.savings = "\(Int(goal.savings)! + amount)"
        updateUI()
        if goal.savings >= goal.price {
            goal.isDone = true
            congrats()
        }
    }
    
    private func congrats() {
        let alert = UIAlertController(title: "🥳 П О З Д Р А В Л Я Ю 🥳", message: "Вы накопили на цель: \(goal.name)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "У Р А !", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
