//
//  DriverRequestedTableViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 05/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class DriverRequestedTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}
