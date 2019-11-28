//
//  HomeTableViewController.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 14/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class HomeTableViewController: UITableViewController {
    
    var drivers: [DriverModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieving information from firestore and building
        // drivers as objects
        FirestoreManager.shared.buildDrivers { (drivers) in
            self.drivers = drivers
            OperationQueue.main.addOperation {
               self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drivers?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "driversCell", for: indexPath)
        if let driver = drivers?[indexPath.row] {
            FirebaseManager.downloadImage(withURL:
            URL(string: driver.profileImageURL)!) {
                image in cell.imageView?.image = image
                cell.textLabel?.text = driver.name
            }
        }
        
        return cell
    }
}
