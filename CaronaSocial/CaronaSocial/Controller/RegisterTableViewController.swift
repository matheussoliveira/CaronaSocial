//
//  RegisterViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 07/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class RegisterTableViewController: UITableViewController {
    
    @IBOutlet var registerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Remover separator line in table view
        registerTableView.separatorStyle = .none
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let footerView = UIView()
        registerTableView.tableFooterView = footerView
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if indexPath.section == 0 {
//            switch indexPath.row {
//            default:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "sectionZero", for: indexPath)
//                return cell
//            }
//        } else if indexPath.section == 1 {
//            switch indexPath.row {
//            case 0:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "institution", for: indexPath)
//                return cell
//            case 1:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "register", for: indexPath)
//                return cell
//            default:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
//                return cell
//            }
//        } else if indexPath.section == 2 {
//            if indexPath.row == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "continue", for: indexPath)
//                return cell
//            }
//        }
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "name", for: indexPath)
//        return cell
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "institutions" {
            let institution = segue.destination as! InstitutionTableViewController

        }
    }
    
    
}
