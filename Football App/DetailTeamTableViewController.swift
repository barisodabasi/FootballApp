//
//  DetailTeamTableViewController.swift
//  Football App
//
//  Created by BarisOdabasi on 24.05.2021.
//

import UIKit

class DetailTeamTableViewController: UITableViewController {
  
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }



}
