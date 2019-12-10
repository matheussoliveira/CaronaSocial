//
//  DriverRequestedTableViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 05/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class DriverRequestedTableViewController: UITableViewController{
    var driver: UserModel?
    var ride: RideModel?
    var activityIndicatorView: UIActivityIndicatorView!
    var group = DispatchGroup()
    
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var driverPhoto: UIImageView!
    @IBOutlet weak var seats: UILabel!
    @IBOutlet weak var accessibility: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var destiny: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var observation: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
//        driverName.text = "oi"
//        accessibility.text = ride?.accessibility
//        seats.text = ride?.vacant
//        origin.text = ride?.origin
//        destiny.text = ride?.destiny
//        time.text = ride?.time
//        observation.text = ride?.observation

    }
    
    override func viewDidAppear(_ animated: Bool) {
//        driverName.text = driver?.name
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
}
