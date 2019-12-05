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
var isOffering: Bool = false

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
    var inputErrorDetected: Bool = false
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        let footerView = UIView()
        registerTableView.tableFooterView = footerView
        
        hideKeyboardWhenTappedAround()
        keyboardEvents()
        
        setCancelButton()
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
        registerTableView.reloadRows(at: [IndexPath(row: 5, section: 0)], with: .automatic)
    }
    
    func checkStudentInputs() {
        var row: Int = 0
        for i in 2...6 {
            row = i
            if row == 5 {
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

                    if row == 2 {
                        name = "Nome do Aluno"
                    } else if row == 3 {
                        name = "CPF do Aluno"
                    } else if row == 4 {
                        name = "Idade do Aluno"
                    } else if row == 6 {
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
        for i in 2...9 {
            row = i
            if row != 5 && row != 6 {
                var name: String = ""
                
                if registerScreen == 2 {
                    name = "Responsável"
                } else if registerScreen == 0 {
                    name = "Funcionário"
                }
                
                let cell = registerTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! TextFieldTableViewCell
                if cell.cellTextField.text?.isEmpty ?? false {
                    var placeholder: String = ""
                    
                    if row == 2 {
                        placeholder = "Nome do \(name)"
                    } else if row == 3 {
                        placeholder = "CPF do \(name)"
                    } else if row == 4 {
                        placeholder = "Telefone"
                    } else if row == 7 {
                        placeholder = "Email"
                    } else if row == 8 {
                        placeholder = "Senha"
                    } else if row == 9 {
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
    
    @IBAction func addPhoto(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }

}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if registerScreen == 1 {
            return 9
        } else if registerScreen == 2 || registerScreen == 0 {
            return 12
        }
        return 9
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
            removeCellSeparatorLines(cell)
            cell.selectionStyle = .none
            return cell
        case 1:
            if registerScreen == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
                cell.selectionStyle = .none
                removeCellSeparatorLines(cell)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "profilePic", for: indexPath) as! ProfilePicTableViewCell
                return cell
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Nome do \(name)"
            cell.cellTextField.keyboardType = .default
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "CPF do \(name)"
            cell.cellTextField.keyboardType = .numberPad
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 4:
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
        case 5:
            if registerScreen == 1 || registerScreen == 0 {
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
            } else if registerScreen == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
                // Remove the lines from the cell
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
                cell.selectionStyle = .none
                tableView.separatorColor = .darkGray
                return cell
            }
        case 6:
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
        case 7:
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
            
        case 8:
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
        case 9:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Confirmar Senha"
            cell.cellTextField.keyboardType = .default
            cell.cellTextField.isSecureTextEntry = true
            cell.selectionStyle = .none
            tableView.separatorColor = .darkGray
            return cell
        case 11:
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
                self.navigationController?.pushViewController(newRegisterViewController, animated: true)
            } else if registerScreen == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
                let newRegisterViewController = storyBoard.instantiateViewController(withIdentifier: "Offer") as! OfferViewController
                self.navigationController?.pushViewController(newRegisterViewController, animated: true)
            }
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        
        if registerScreen == 1 { //student
            if indexPath.row == 1 {
                height = 0
            } else {
                height = 62
            }
        } else if registerScreen == 2 {
            if indexPath.row == 1 {
                height = 150
            } else if indexPath.row == 5 {
                height = 20
            } else {
                height = 62
            }
        } else if registerScreen == 0 {
            if indexPath.row == 1 {
                height = 150
            } else {
                height = 62
            }
        }
        
        return height
    }
    
    func buildStudentInfo() {
        if registerScreen == 1 {
            let studentName = registerTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextFieldTableViewCell
            let studentCPF = registerTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! TextFieldTableViewCell
            let studentAge = registerTableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! TextFieldTableViewCell
            let institution = registerTableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! TitleTableViewCell
            let matriculation = registerTableView.cellForRow(at: IndexPath(row: 6, section: 0)) as! TextFieldTableViewCell
            self.studentName = studentName.cellTextField.text ?? "Não pegou"
            self.studentCPF = studentCPF.cellTextField.text ?? "Não pegou"
            self.studentAge = studentAge.cellTextField.text ?? "Não pegou"
            self.institution = institution.cellSkyTextField.text ?? "Não pegou"
            self.matriculation = matriculation.cellTextField.text ?? "Não pegou"
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
            print(registerScreen)
        case 2:
            // Seek or offer ride screen
            print(registerScreen)
        default:
            print("error")
        }
        
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let cell = registerTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ProfilePicTableViewCell
            cell.profileImageView.image = image
            
            registerTableView.reloadInputViews()
        }
        
        dismiss(animated: true, completion: nil)
    }
}
