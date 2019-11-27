//
//  RegisterLocationViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 27/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class RegisterLocationViewController: UIViewController {
    
    @IBOutlet weak var locationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let footerView = UIView()
        locationTableView.tableFooterView = footerView
    }
}

extension RegisterLocationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationTableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath)
        
        switch indexPath.row {
        case 1: //Street
            return cell
        case 2: //Number
            return cell
        case 3: //Neighborhood
            return cell
        case 4: //City
            return cell
        case 5: //State
            return cell
        case 6: //Picker
            return cell
        case 8: //Button
            return cell
        default: //case 0 and 7
            let cell = locationTableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
            // Remove the lines from the cell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        }
    }
    
}
