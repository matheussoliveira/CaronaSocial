//
//  FixLocationsViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 26/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class FixLocationsViewController: UIViewController {
    
    @IBOutlet weak var locationsTableView: UITableView!
    
    var houseAdress: String = "Casa"
    var institutionAdress: String = "Instituição"
    var workAdress: String = "Trabalho"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let footerView = UIView()
        locationsTableView.tableFooterView = footerView
    }
    
}

extension FixLocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "progress", for: indexPath) as! ImageTableViewCell
            if registerScreen == 0 { //Employee screens
                cell.cellImage.image = UIImage(named: "progress23")
            } else if registerScreen == 1 || registerScreen == 2 {
                cell.cellImage.image = UIImage(named: "progress4")
            }
            // Remove the lines from the cell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            cell.selectionStyle = .none
            return cell
        case 1: //House
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! TitleTableViewCell
            cell.cellSkyTextField.iconImage = UIImage.init(systemName: "house.fill")
            cell.cellIcon.image = UIImage.init(systemName: "house.fill")
            cell.cellPlaceholder.text = "Casa"
            cell.cellSkyTextField.text = houseAdress
            
            if houseAdress == "Casa" {
                cell.cellPlaceholder.isHidden = false
                cell.cellIcon.isHidden = false
            } else {
                cell.cellSkyTextField.textColor = .black
                cell.cellPlaceholder.isHidden = true
                cell.cellIcon.isHidden = true
            }

            return cell
        case 2: //Institution
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! TitleTableViewCell
            cell.cellSkyTextField.iconImage = UIImage(named: "building")
            cell.cellIcon.image = UIImage(named: "building")
            cell.cellPlaceholder.text = "Instituição"
            cell.cellSkyTextField.text = institutionAdress
            
            if institutionAdress == "Instituição" {
                cell.cellPlaceholder.isHidden = false
                cell.cellIcon.isHidden = false
            } else {
                cell.cellSkyTextField.textColor = .black
                cell.cellPlaceholder.isHidden = true
                cell.cellIcon.isHidden = true
            }
            return cell
        case 3: //Work
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! TitleTableViewCell
            cell.cellSkyTextField.iconImage = UIImage.init(systemName: "briefcase.fill")
            cell.cellIcon.image = UIImage.init(systemName: "briefcase.fill")
            cell.cellPlaceholder.text = "Trabalho (Opcional)"
            cell.cellSkyTextField.text = workAdress
            
            if workAdress == "Trabalho" {
                cell.cellPlaceholder.isHidden = false
                cell.cellIcon.isHidden = false
            } else {
                cell.cellSkyTextField.textColor = .black
                cell.cellPlaceholder.isHidden = true
                cell.cellIcon.isHidden = true
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath)
            return cell
        }
    }
    
}
