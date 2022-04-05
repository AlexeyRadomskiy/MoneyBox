//
//  DataManager.swift
//  MoneyBox
//
//  Created by Alexey on 05.04.2022.
//

class DataManager {
    
    static let shared = DataManager()
    
    let goalName = ["Кубик-рубика", "Бионикл", "Машинка"]
    let photo = ["kubikRubika", "bionicle", "ferrariCar"]
    let price = [300, 800, 1200]
    let savings = [0, 0, 100]
    let income = [50, 100, 200]
    
    private init() {}
}
