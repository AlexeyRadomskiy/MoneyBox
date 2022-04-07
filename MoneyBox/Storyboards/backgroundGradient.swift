//
//  backgroundGradient.swift
//  MoneyBox
//
//  Created by mac mini on 4/8/22.
//

import UIKit

extension UIViewController {
    
    func setGradientOnBackground(firstColor: UIColor, secondColor: UIColor) {
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
}


