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
    
    // Student data
    var studentName: String = ""
    var studentCPF: String = ""
    var studentAge: String = ""
    var institution: String = ""
    var matriculation: String = ""
    var responsableName: String = ""
    var responsableCPF: String = ""
    var responsableTelephone: String = ""
    var email: String = ""
    var passaword: String = ""
    var passwordConfirmation: String = ""
    var institutionName: String = "Instituição"
    
    // Employee data
    var employeeName: String = ""
    var employeeCPF: String = ""
    var telephone: String = ""
    var employeeEmail: String = ""
    var employeePassaword: String = ""
    var employeePassawordConfirmation: String = ""
    var user: EmplyeeDriverModel?
    
    
    var inputErrorDetected: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        let footerView = UIView()
        registerTableView.tableFooterView = footerView
        
        hideKeyboardWhenTappedAround()
        keyboardEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if registerScreen == 1 {
            self.title = "Cadastrar Aluno"
        } else if registerScreen == 2 {
            self.title = "Cadastrar Responsável"
        } else if registerScreen == 0 {
            self.title = "Cadastrar Funcionário"
        }
        
        
    }
    
    override func keyboardWillShow(_ notification: Notification, tableView: UITableView) {
        super.keyboardWillShow(notification, tableView: registerTableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //when the back button is tapped
        if self.isMovingFromParent {
            registerScreen -= 1
        }
    }
    
    @IBAction func selectedInstitution(segue: UIStoryboardSegue) {
        let selectedInstitutionViewController = segue.source as! InstitutionTableViewController
        
        let selectedInstitution = selectedInstitutionViewController.selectedInstitution
        institutionName = selectedInstitution
        registerTableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
    }
    
    func checkStudentInputs() {
        var row: Int = 0
        for i in 1...5 {
            row = i
            if row == 4 {
                let studentCell = registerTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! TitleTableViewCell
                
                if institutionName == "Instituição" {
                    studentCell.cellPlaceholder.text = "Instituição"
                    studentCell.cellSkyTextField.isHidden = true
                    shakeLabel(label: studentCell.cellPlaceholder, for: 1.0, labelColor: UIColor.placeholderText)
                    inputErrorDetected = true
                }
                
            } else {
                let studentCell = registerTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! TextFieldTableViewCell

                if studentCell.cellTextField.text?.isEmpty ?? false {
                    var name: String = ""

                    if row == 1 {
                        name = "Nome do Aluno"
                    } else if row == 2 {
                        name = "CPF do Aluno"
                    } else if row == 3 {
                        name = "Idade do Aluno"
                    } else if row == 5 {
                        name = "Matrícula do Aluno"
                    }

                    shakeTextField(textField: studentCell.cellTextField, for: 1.0, placeholder: name, textColor: .black)
                    inputErrorDetected = true
                } else {
                    if institutionName != "Instituição" {
                        inputErrorDetected = false
                    }
                }
            }
        }
        
    }
    
    func checkResponsableOrEmployeeInputs() {
        var row: Int = 0
        for i in 1...8 {
            row = i
            if row != 4 && row != 5 {
                var name: String = ""
                
                if registerScreen == 2 {
                    name = "Responsável"
                } else if registerScreen == 0 {
                    name = "Funcionário"
                }
                
                let cell = registerTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! TextFieldTableViewCell
                if cell.cellTextField.text?.isEmpty ?? false {
                    var placeholder: String = ""
                    
                    if row == 1 {
                        placeholder = "Nome do \(name)"
                    } else if row == 2 {
                        placeholder = "CPF do \(name)"
                    } else if row == 3 {
                        placeholder = "Telefone"
                    } else if row == 6 {
                        placeholder = "Email"
                    } else if row == 7 {
                        placeholder = "Senha"
                    } else if row == 8 {
                        placeholder = "Confirmar Senha"
                    }
                    
                    shakeTextField(textField: cell.cellTextField, for: 1.0, placeholder: placeholder, textColor: .black)
                    inputErrorDetected = true
                } else {
                    inputErrorDetected = false
                }
            }
        }

    }

}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if registerScreen == 1 {
            return 8
        } else if registerScreen == 2 || registerScreen == 0 {
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
        } else if registerScreen == 2 {
            name = "Responsável"
            imageName = "progress2"
        } else if registerScreen == 0 {
            name = "Funcionário"
            imageName = "progress21"
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
            } else if registerScreen == 2 || registerScreen == 0 {
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
                cell.cellSkyTextField.text = institutionName
                
                if institutionName == "Instituição" {
                    cell.cellPlaceholder.isHidden = false
                } else {
                    cell.cellSkyTextField.textColor = .black
                    cell.cellPlaceholder.isHidden = true
                }

                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            } else if registerScreen == 2 || registerScreen == 0 {
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
            } else if registerScreen == 2 || registerScreen == 0 {
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
            } else if registerScreen == 2 || registerScreen == 0 {
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
            } else if registerScreen == 2 || registerScreen == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
                cell.cellTextField.placeholder = "Senha"
                cell.cellTextField.keyboardType = .default
                cell.cellTextField.isSecureTextEntry = true
                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            }
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Confirmar Senha"
            cell.cellTextField.keyboardType = .default
            cell.cellTextField.isSecureTextEntry = true
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
            checkStudentInputs()
        } else if registerScreen == 2 || registerScreen == 0 {
            checkResponsableOrEmployeeInputs()
            buildStudentInfo()
        
            self.user = EmplyeeDriverModel(type: "driver", name: employeeName,
                                          cpf: employeeCPF, telephone: telephone,
                                          email: employeeEmail)
            
            // TODO: Send this object to next view
            
        }
        
        if inputErrorDetected == false {
            if registerScreen == 1 {
                registerScreen = 2
                let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
                let newRegisterViewController = storyBoard.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
                self.navigationController?.pushViewController(newRegisterViewController, animated: true)
            } else if registerScreen == 2 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
                let newRegisterViewController = storyBoard.instantiateViewController(withIdentifier: "SeekOrOffer") as! SeekOrOfferViewController
                newRegisterViewController.user = self.user
                self.navigationController?.pushViewController(newRegisterViewController, animated: true)
            } else if registerScreen == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
                let newRegisterViewController = storyBoard.instantiateViewController(withIdentifier: "Offer") as! OfferViewController
                self.navigationController?.pushViewController(newRegisterViewController, animated: true)
            }
        }

    }
    
    func buildStudentInfo() {
        if registerScreen == 1 {
            let studentName = registerTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextFieldTableViewCell
            let studentCPF = registerTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextFieldTableViewCell
            let studentAge = registerTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! TextFieldTableViewCell
            let institution = registerTableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! TitleTableViewCell
            let matriculation = registerTableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! TextFieldTableViewCell
            self.studentName = studentName.cellTextField.text ?? "Não pegou"
            self.studentCPF = studentCPF.cellTextField.text ?? "Não pegou"
            self.studentAge = studentAge.cellTextField.text ?? "Não pegou"
            self.institution = institution.cellSkyTextField.text ?? "Não pegou"
            self.matriculation = matriculation.cellTextField.text ?? "Não pegou"
        } else if registerScreen == 2 || registerScreen == 0 {
            let employeeName = registerTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextFieldTableViewCell
            let employeeCPF = registerTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextFieldTableViewCell
            let telephone = registerTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! TextFieldTableViewCell
            let employeeEmail = registerTableView.cellForRow(at: IndexPath(row: 6, section: 0)) as! TextFieldTableViewCell
            let employeePassaword = registerTableView.cellForRow(at: IndexPath(row: 7, section: 0)) as! TextFieldTableViewCell
            let employeePassawordConfirmation = registerTableView.cellForRow(at: IndexPath(row: 8, section: 0)) as! TextFieldTableViewCell
            self.employeeName = employeeName.cellTextField.text ?? "Nome inválido"
            self.employeeCPF = employeeCPF.cellTextField.text ?? "Nome inválido"
            self.telephone = telephone.cellTextField.text ?? "Nome inválido"
            self.employeeEmail = employeeEmail.cellTextField.text ?? "Nome inválido"
            self.employeePassaword = employeePassaword.cellTextField.text ?? "Nome inválido"
            self.employeePassawordConfirmation = employeePassawordConfirmation.cellTextField.text ?? "Nome inválido"
        }
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        switch registerScreen {
        case 0:
            // Student informations screen
            buildStudentInfo()
            print(studentName, studentCPF, studentAge, institution, matriculation)
        case 1:
            //  Parents information screen
            print(employeeName, employeeCPF, telephone, employeeEmail, employeePassaword, employeePassawordConfirmation)
        case 2:
            // Seek or offer ride screen
            print(registerScreen)
        default:
            print("error")
        }
        
    }
    
}
