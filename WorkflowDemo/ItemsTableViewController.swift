//
//  ItemsTableViewController.swift
//  WorkflowDemo
//
//  Created by Hugues Stéphano TELOLAHY on 6/4/19.
//  Copyright © 2019 Hugues Stéphano TELOLAHY. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = "Item"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let stepsNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StepsNavigationController") as? UINavigationController,
            let stepsViewController = stepsNavigationController.viewControllers.first as? StepsViewController else {
                return
        }
        stepsViewController.currentIndex = 3
        navigationController?.present(stepsNavigationController, animated: true)
    }
    
}
