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
    
    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // Tentar colocar a imagem dentro de complition para ver se carrega certo
        
        if let driver = drivers?[indexPath.row] {
            cell.textLabel?.text = driver.name
            cell.imageView?.isHidden = false
            FirebaseAuthManager.downloadImage(withURL:
            URL(string: "https://firebasestorage.googleapis.com/v0/b/caronasocial-4ffa6.appspot.com/o/Images%2FLipinho.jpg?alt=media&token=5f6e41fc-264d-4a8e-8202-6067772b6d12")!) {
                image in cell.imageView?.image = image
            }
        }
        
        return cell
    }
}
