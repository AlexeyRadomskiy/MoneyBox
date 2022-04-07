//
//  WelcomeViewController.swift
//  MoneyBox
//
//  Created by mac mini on 4/8/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        setGradientOnBackground(firstColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), secondColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    }
}
