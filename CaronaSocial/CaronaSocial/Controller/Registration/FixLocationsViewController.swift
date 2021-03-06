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
    
    var cellTitle: [String] = ["Casa", "Instituição", "Trabalho"]
    var registerLocationTitle: String = ""
    
    var houseAddress: String = ""
    var institutionAddress: String = ""
    var workAddress: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let footerView = UIView()
        locationsTableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationsTableView.reloadData()
    }
    
    @IBAction func backToFixLocations(segue: UIStoryboardSegue) {
        
    }
}

extension FixLocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
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
            removeCellSeparatorLines(cell)
            return cell
        case 1: //House
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! TitleTableViewCell
            cell.cellSkyTextField.iconImage = UIImage.init(systemName: "house.fill")
            cell.cellIcon.image = UIImage.init(systemName: "house.fill")
            cell.cellPlaceholder.text = "Casa"
            cell.cellSkyTextField.text = houseAddress
            
            if houseAddress == "" {
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
            cell.cellSkyTextField.text = institutionAddress
            
            if institutionAddress == "" {
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
            cell.cellSkyTextField.text = workAddress
            
            if workAddress == "" {
                cell.cellPlaceholder.isHidden = false
                cell.cellIcon.isHidden = false
            } else {
                cell.cellSkyTextField.textColor = .black
                cell.cellPlaceholder.isHidden = true
                cell.cellIcon.isHidden = true
            }
            return cell
        case 5: //Button continue
            let cell = tableView.dequeueReusableCell(withIdentifier: "button", for: indexPath) as! ButtonTableViewCell
            removeCellSeparatorLines(cell)
            return cell
        default: //Blank
            let cell = tableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
            removeCellSeparatorLines(cell)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 {
            registerLocationTitle = cellTitle[indexPath.row - 1]
        
            //Move to RegisterLocationViewController
            let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "registerLocation") as! RegisterLocationViewController
            vc.navigationTitle = "Cadastrar \(registerLocationTitle)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
