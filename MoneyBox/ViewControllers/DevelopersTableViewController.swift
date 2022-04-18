//
//  DevelopersTableViewController.swift
//  MoneyBox
//
//  Created by mac mini on 4/18/22.
//

import UIKit

class DevelopersTableViewController: UITableViewController {
    
    let developersData = [
        Developer(name: "Alexey Radomskiy", city: "Moscow", telegram: "@AlexeyRadomskiy", photo: "alexey"),
        Developer(name: "Sayabek Nurmagambetov", city: "Astana", telegram: "@whysoser1ous", photo: "sayabeck")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.tableFooterView = UIView()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        developersData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! CustomTableViewCell
        
        cell.nameLabel.text = developersData[indexPath.row].name
        cell.cityLabel.text = developersData[indexPath.row].city
        cell.telegramLabel.text = "telegram: \(developersData[indexPath.row].telegram)"
        cell.photo.image = UIImage(named: developersData[indexPath.row].photo)
        cell.photo.layer.cornerRadius = cell.photo.frame.size.height / 2

        return cell
    }
}
