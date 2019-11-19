//
//  RegisterViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 19/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

protocol ContinueDelegate: NSObjectProtocol {
    func continueButton()
}

class RegisterViewController: UIViewController, ContinueDelegate {
    
    @IBOutlet weak var registerTableView: UITableView!

    var institutionName: String = "Instituição"
    var registerScreen: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let footerView = UIView()
        registerTableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerScreen = LoginViewController.shared.registerScreenNumber
        
        self.title = "Cadastro do Aluno"
    }
    
    @IBAction func selectedInstitution(segue: UIStoryboardSegue) {
        let selectedInstitutionViewController = segue.source as! InstitutionTableViewController
        
        let selectedInstitution = selectedInstitutionViewController.selectedInstitution
        institutionName = selectedInstitution
        registerTableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
    }

}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "progress", for: indexPath) as! ImageTableViewCell
            cell.cellImage.image = UIImage(named: "progress1")
            // Remove the lines from the cell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Nome do Aluno"
            cell.cellTextField.keyboardType = .default
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Idade do Aluno"
            cell.cellTextField.keyboardType = .numberPad
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "CPF do Aluno"
            cell.cellTextField.keyboardType = .numberPad
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! TitleTableViewCell
            cell.cellTitle.text = institutionName
            
            if institutionName == "Instituição" {
                cell.cellTitle.textColor = .placeholderText
            } else {
                cell.cellTitle.textColor = .black
            }

            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Matrícula"
            cell.cellTextField.keyboardType = .numberPad
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
            // Remove the lines from the cell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "button", for: indexPath) as! ButtonTableViewCell
            // Remove the lines from the cell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        }
    }
    
    func continueButton() {
        
    }
    
}
