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
    var user: EmployeeDriverModel?
    var responsable: ResponsableModel?
    var userID: String?
    
    var cellTitle: [String] = ["Casa", "Instituição", "Trabalho"]
    var registerLocationTitle: String = ""
    
    var houseAddress: String = ""
    var institutionAddress: String = ""
    var workAddress: String = ""
    
    var inputErrorDetect: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Fix locations: \(responsable)")

        let footerView = UIView()
        locationsTableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationsTableView.reloadData()
    }
    
    func checkLocationsInput() {
        var row: Int = 0
        
        for i in 1...2 {
            row = i
            let cell = locationsTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! TitleTableViewCell
            if cell.cellSkyTextField.text?.isEmpty ?? false {
                shakeLabel(label: cell.cellPlaceholder, for: 1.0, labelColor: .placeholderText)
                inputErrorDetect = true
            } else {
                inputErrorDetect = false
            }
        }
    }
    
    @IBAction func backToFixLocations(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        //Sends all register information to firebase
        
        checkLocationsInput()
        
        if inputErrorDetect == false {
            
            if user != nil {
                
                FirebaseManager.shared.createUser(email: user!.email,
                                                  password: user!.password) { result in
                    
                    if (result) {// User did created a account on Carona Social
                        
                        // TODO: Needs to send user back to login screen (?)
                        
                        FirebaseManager.shared.singIn(email: self.user!.email, password: self.user!.password)
                        if (FirebaseManager.shared.getUserID() != "none") {
                            self.userID = FirebaseManager.shared.getUserID()
                            
                            FirestoreManager.shared.sendEmployeeDriver(name: self.user!.name,
                                                                      cpf: self.user!.cpf,
                                                                      telephone: self.user!.telephone,
                                                                      email: self.user!.email,
                                                                      userID: self.userID!)
                            
                            FirestoreManager.shared.sendLocation(userID: self.userID!, home: self.houseAddress, institution: self.institutionAddress, work: self.workAddress)
                        }
                        
                    } else { // Account creation failed
                        print("Failed to create a user!")
                    }
                }
            } else if responsable != nil {
                
                FirebaseManager.shared.createUser(email: responsable!.email,
                                                  password: responsable!.password) { result in
                    
                    if (result) {// Responsable did created a account on Carona Social
                        
                        // TODO: Needs to send user back to login screen (?)
                        
                        FirebaseManager.shared.singIn(email: self.responsable!.email, password: self.responsable!.password)
                        if (FirebaseManager.shared.getUserID() != "none") {
                            self.userID = FirebaseManager.shared.getUserID()
                            
                            FirestoreManager.shared.sendResponsable(
                                responsableName: self.responsable!.responsableName,
                                responsableCPF: self.responsable!.responsableCPF,
                                telephone: self.responsable!.telephone,
                                email: self.responsable!.email,
                                userID: self.userID!)
                            
                            FirestoreManager.shared.sendStudent(
                                institution: self.responsable!.studentInstitution,
                                studentName: self.responsable!.studentName,
                                studentCPF: self.responsable!.studentCPF,
                                studentAge: self.responsable!.studentAge,
                                matriculation: self.responsable!.matriculation,
                                userID: self.userID!)
                            
                            FirestoreManager.shared.sendLocation(userID: self.userID!, home: self.houseAddress, institution: self.institutionAddress, work: self.workAddress)
                        }
                        
                    } else { // Account creation failed
                        print("Failed to create a user!")
                    }
                }
                
                
            }
            
            // If all inputs are ok, perform segue
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
//            let newRegisterViewController = storyBoard.instantiateViewController(withIdentifier: "infos") as! AditionalInfoViewController
//            self.navigationController?.pushViewController(newRegisterViewController, animated: true)
        }
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
            cell.cellSkyTextField.title = "Casa"
            cell.cellSkyTextField.text = houseAddress
            
            if houseAddress == "" {
                cell.cellPlaceholder.isHidden = false
                cell.cellIcon.isHidden = false
                cell.cellSkyTextField.isHidden = true
            } else {
                cell.cellSkyTextField.textColor = .black
                cell.cellSkyTextField.isHidden = false
                cell.cellPlaceholder.isHidden = true
                cell.cellIcon.isHidden = true
            }

            return cell
        case 2: //Institution
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! TitleTableViewCell
            cell.cellSkyTextField.iconImage = UIImage(named: "building")
            cell.cellIcon.image = UIImage(named: "building")
            cell.cellPlaceholder.text = "Instituição"
            cell.cellSkyTextField.title = "Instituição"
            cell.cellSkyTextField.text = institutionAddress
            
            if institutionAddress == "" {
                cell.cellPlaceholder.isHidden = false
                cell.cellIcon.isHidden = false
                cell.cellSkyTextField.isHidden = true
            } else {
                cell.cellSkyTextField.textColor = .black
                cell.cellPlaceholder.isHidden = true
                cell.cellSkyTextField.isHidden = false
                cell.cellIcon.isHidden = true
            }
            return cell
        case 3: //Work
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! TitleTableViewCell
            cell.cellSkyTextField.iconImage = UIImage.init(systemName: "briefcase.fill")
            cell.cellIcon.image = UIImage.init(systemName: "briefcase.fill")
            cell.cellPlaceholder.text = "Trabalho (Opcional)"
            cell.cellSkyTextField.title = "Trabalho"
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
