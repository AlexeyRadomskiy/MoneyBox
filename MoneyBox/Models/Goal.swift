//
//  Goal.swift
//  MoneyBox
//
//  Created by Alexey on 05.04.2022.
//

import UIKit

struct Goal {
    let goalName: String
    let photo: String
    let price: Int
    var savings: Int
    let income: Int
}

extension Goal {
    static func getGoalList() -> [Goal] {
        
        var goals: [Goal] = []
        
        let goalNames = DataManager.shared.goalName
        let photos = DataManager.shared.photo
        let prices = DataManager.shared.price
        let savingsData = DataManager.shared.savings
        let incomes = DataManager.shared.income
        
        let iterationCount = min(goalNames.count, photos.count, prices.count, savingsData.count, incomes.count)
        
        for index in 0..<iterationCount {
            let goal = Goal(
                goalName: goalNames[index],
                photo: photos[index],
                price: prices[index],
                savings: savingsData[index],
                income: incomes[index]
            )
            
            goals.append(goal)
        }
        
        return goals
    }
}
