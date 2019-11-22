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

var registerScreen: Int = 0

class RegisterViewController: UIViewController, ContinueDelegate {
    
    @IBOutlet weak var registerTableView: UITableView!

    var institutionName: String = "Instituição"

    override func viewDidLoad() {
        super.viewDidLoad()

        let footerView = UIView()
        registerTableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if registerScreen == 1 {
            self.title = "Cadastro Aluno"
        } else if registerScreen == 2 {
            self.title = "Cadastro Responsável"
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent { //when the back button is tapped
            registerScreen -= 1
        }
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
        if registerScreen == 1 {
            return 8
        } else if registerScreen == 2 {
            return 11
        }
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var name: String = ""
        var imageName: String = ""
        
        if registerScreen == 1 {
            name = "Aluno"
            imageName = "progress1"
        } else if registerScreen == 2{
            name = "Responsável"
            imageName = "progress2"
        }
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "progress", for: indexPath) as! ImageTableViewCell
            cell.cellImage.image = UIImage(named: imageName)
            // Remove the lines from the cell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Nome do \(name)"
            cell.cellTextField.keyboardType = .default
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "CPF do \(name)"
            cell.cellTextField.keyboardType = .numberPad
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 3:
            if registerScreen == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
                cell.cellTextField.placeholder = "Idade do Aluno"
                cell.cellTextField.keyboardType = .numberPad
                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            } else if registerScreen == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
                cell.cellTextField.placeholder = "Telefone"
                cell.cellTextField.keyboardType = .numberPad
                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            }
        case 4:
            if registerScreen == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! TitleTableViewCell
                cell.cellTitle.text = institutionName
                
                if institutionName == "Instituição" {
                    cell.cellPlaceholder.isHidden = false
                } else {
                    cell.cellTitle.textColor = .black
                    cell.cellPlaceholder.isHidden = true
                }

                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            } else if registerScreen == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
                // Remove the lines from the cell
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            }
        case 5:
            if registerScreen == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
                cell.cellTextField.placeholder = "Matrícula"
                cell.cellTextField.keyboardType = .numberPad
                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            } else if registerScreen == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelTableViewCell
                cell.cellLabel.text = "Informações para Login"
                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            }
        case 6:
            if registerScreen == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
                // Remove the lines from the cell
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            } else if registerScreen == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
                cell.cellTextField.placeholder = "Email"
                cell.cellTextField.keyboardType = .emailAddress
                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            }
            
        case 7:
            if registerScreen == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "button", for: indexPath) as! ButtonTableViewCell
                cell.delegate = self
                // Remove the lines from the cell
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            } else if registerScreen == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
                cell.cellTextField.placeholder = "Senha"
                cell.cellTextField.keyboardType = .default
                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            }
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Confirmar Senha"
            cell.cellTextField.keyboardType = .default
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 10:
            let cell = tableView.dequeueReusableCell(withIdentifier: "button", for: indexPath) as! ButtonTableViewCell
            cell.delegate = self
            // Remove the lines from the cell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            // Remove the lines from the cell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
        cell.selectionStyle = .none
        tableView.separatorColor = .darkGray
        return cell
    }
    
    func continueButton() {
        if registerScreen == 1 {
            registerScreen = 2
            let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
            let newRegisterViewController = storyBoard.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
            self.navigationController?.pushViewController(newRegisterViewController, animated: true)
        } else if registerScreen == 2 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
            let newRegisterViewController = storyBoard.instantiateViewController(withIdentifier: "SeekOrOffer") as! SeekOrOfferViewController
            self.navigationController?.pushViewController(newRegisterViewController, animated: true)
        }
    }
    
}



/*
- Back button - change register screen number
- don't use global variable
*/
