//
//  InstitutionViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 18/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class InstitutionTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var institutionTableView: UITableView!

    var institutionNames: [String] = ["APAE", "Boldrini", "Fundação FEAC", "Adacamp"]

    var selectedInstitution: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Remove aditional table view lines
        let footerView = UIView()
        institutionTableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return institutionNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "institutionCell", for: indexPath)
        cell.textLabel?.text = institutionNames[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let selectedInstitution = institutionNames[indexPath.row]
////
////        let destinationVC = RegisterViewController()
////        destinationVC.institutionName = selectedInstitution
////
////        destinationVC.performSegue(withIdentifier: "institution", sender: self)
//    }
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedInstitution" {
            let cell = sender as! UITableViewCell
            let index = tableView.indexPath(for: cell)
            if let indexPath = index?.row {
                selectedInstitution = institutionNames[indexPath]
            }
        }
    }
    
}
