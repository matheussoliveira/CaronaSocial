//
//  DriverRequestedTableViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 05/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class DriverRequestedTableViewController: UITableViewController {
    var driver: UserModel?
    var ride: RideModel?
    var activityIndicatorView: UIActivityIndicatorView!
    var rows: [String]?
    var group = DispatchGroup()
    
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var driverPhoto: UIImageView!
    @IBOutlet weak var seats: UILabel!
    @IBOutlet weak var accessibility: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var destiny: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var observation: UITextView!
    
    override func loadView() {
        super.loadView()

        activityIndicatorView = UIActivityIndicatorView(style: .gray)

        tableView.backgroundView = activityIndicatorView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.driverName.text = driver?.name
        self.accessibility.text = ride?.accessibility
        self.seats.text = ride?.vacant
        self.origin.text = ride?.origin
        self.destiny.text = ride?.destiny
        self.time.text = ride?.time
        self.observation.text = ride?.observation
        
        self.rows = ["One", "Two"]

        self.activityIndicatorView.stopAnimating()

        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (rows == nil) {
            activityIndicatorView.startAnimating()
            tableView.separatorStyle = .none
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
}
