//
//  DriverMatchTableViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 05/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class DriverMatchTableViewController: UITableViewController {
    
    var driver: DriverModel?
    var newImage: UIImage?
    var ride: RideModel?

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var vacantyNumber: UILabel!
    @IBOutlet weak var accessibility: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var destiny: UILabel!
    @IBOutlet weak var observation: UITextView!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        print("Teste: \(driver?.name)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImage.image = newImage
        profileImage.makeRounded()
        name.text = driver?.name
        vacantyNumber.text = driver?.vacantPlaces
        accessibility.text = driver?.accessibility ?? false ? "Sim" : "Não"
        observation.text = driver?.observation ?? "Sem informações"
        vacantyNumber.text = self.ride?.vacant
        accessibility.text = self.ride?.accessibility
        observation.text = self.ride?.observation
        origin.text = self.ride?.origin
        destiny.text = self.ride?.destiny
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

}
