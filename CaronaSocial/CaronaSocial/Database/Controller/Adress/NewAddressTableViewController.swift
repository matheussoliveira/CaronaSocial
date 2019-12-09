//
//  NewAdressTableViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 25/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit
import CoreLocation

class NewAddressTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var neighborhood: UITextField!
    @IBOutlet weak var state: UITextField!
    
    var newAdressLocation: CLLocationCoordinate2D?
    var adressList: AddressTableViewController?
    
    var statePicker = UIPickerView()
    let states = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"]
    var adress: String = ""
    var inputErrorDetected: Bool = false
    
    @IBAction func confirmButtom(_ sender: Any) {
        checkInputInfo()
        
        if inputErrorDetected == false {
            self.adress = "\(street.text ?? ""), \(number.text ?? ""), \(neighborhood.text ?? ""), \(city.text ?? ""), \(state.text ?? "")"
            
            adressList?.addAdress(adress: adress)
            
            let group = DispatchGroup()
            let userID = FirebaseManager.shared.getUserID()
            
            group.enter()
               FirestoreManager.shared.getCoordinate(addressString: self.adress){ result, error in
                   self.newAdressLocation = result
                   group.leave()
               }
            
            group.notify(queue: .main) {
                
                FirestoreManager.shared.sendNewAddress(userID: userID, address: self.adress, coordinates: self.newAdressLocation!)
                
            }
            
            
            
            
            
            performSegue(withIdentifier: "backToAdress", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statePicker.delegate = self
        statePicker.dataSource = self
        state.inputView = statePicker
        
        showPicker()
        hideKeyboardWhenTappedAround()
        
        let footerView = UIView()
        tableView.tableFooterView = footerView
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func checkInputInfo() {
        if street.text?.isEmpty ?? false || number.text?.isEmpty ?? false || neighborhood.text?.isEmpty ?? false || city.text?.isEmpty ?? false || state.text?.isEmpty ?? false {
            
            inputErrorDetected = true
        } else {
            inputErrorDetected = false
        }
        
        let textFields = [street, number, neighborhood, city, state]
        
        for textField in textFields {
            let placeholder = textField?.placeholder ?? ""
            if textField?.text?.isEmpty ?? false {
                shakeTextField(textField: textField!, for: 1.0, placeholder: placeholder, textColor: .black)
            }
        }
    }
    
    // MARK: Picker
    
    func showPicker() {
        // ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Confirmar",
                                           style: .plain,
                                           target: self,
                                           action: #selector(doneConditionPicker))
        
        toolbar.tintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        toolbar.setItems([spaceButton,cancelButton], animated: false)
        
        state.inputAccessoryView = toolbar
    }
    
    @objc func doneConditionPicker() {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        state.text = states[row]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

}
