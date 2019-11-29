//
//  RegisterLocationViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 27/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

//protocol CellTextField: NSObjectProtocol {
//    func textFieldTapped()
//}

class RegisterLocationViewController: UIViewController {
    
    @IBOutlet weak var locationTableView: UITableView!
    
    let states = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"]
    var isPickerHidden: Bool = true
    var pickerCellHeight: CGFloat = 0
    
    var stateCell: TextFieldTableViewCell!
    var pickerCell: PickerTableViewCell!
    
    var navigationTitle: String = ""
    var address: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let footerView = UIView()
        locationTableView.tableFooterView = footerView
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = navigationTitle
    }
}

extension RegisterLocationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1: //Street
            let cell = locationTableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Rua"
            cell.cellTextField.keyboardType = .default
            return cell
        case 2: //Number
            let cell = locationTableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Número"
            cell.cellTextField.keyboardType = .numberPad
            return cell
        case 3: //Neighborhood
            let cell = locationTableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Bairro"
            cell.cellTextField.keyboardType = .default
            return cell
        case 4: //City
            let cell = locationTableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldTableViewCell
            cell.cellTextField.placeholder = "Cidade"
            cell.cellTextField.keyboardType = .default
            return cell
        case 5: //State
            self.stateCell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as? TextFieldTableViewCell
            let cell = self.stateCell
            
            cell?.cellTextField.placeholder = "Estado"
            cell?.cellTextField.isUserInteractionEnabled = false
            return cell!
        case 6: //Picker
            self.pickerCell = tableView.dequeueReusableCell(withIdentifier: "picker", for: indexPath) as? PickerTableViewCell
            let cell = self.pickerCell
            
            //Picker delegate
            self.pickerCell.pickerDelegate = self.stateCell
            
            return cell!
        case 8: //Button
            let cell = locationTableView.dequeueReusableCell(withIdentifier: "button", for: indexPath) as! ButtonTableViewCell
            // Remove the lines from the cell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            cell.selectionStyle = .none
            return cell
        default: //case 0 and 7
            let cell = locationTableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
            // Remove the lines from the cell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        
        if indexPath.row == 6 {
            height = pickerCellHeight
        } else if indexPath.row == 0 {
            height = 5
        } else {
            height = 62
        }
        
        tableView.reloadRows(at: [IndexPath(row: 6, section: 0)], with: .fade)
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let textFieldIndexPath = IndexPath(row: 5, section: 0)
        
        if textFieldIndexPath == indexPath {
            isPickerHidden = !isPickerHidden
            
            if isPickerHidden == false {
                pickerCellHeight = 140
            } else {
                pickerCellHeight = 0
            }
            
            tableView.reloadRows(at: [IndexPath(row: 6, section: 0)], with: .fade)
        }
    }
    
    func getLocationInfos() {
        var infos: [String] = ["street", "number", "neighborhood", "city", "state"]
        
        var row: Int = 0
        
        for i in 1...5 {
            row = i
            let cell = locationTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! TextFieldTableViewCell
            infos[i - 1] = cell.cellTextField.text ?? ""
        }
        
        address = "\(infos[0]), \(infos[1]), \(infos[2]), \(infos[3]), \(infos[4])"
    }
    
    @IBAction func registerLocationButton(_ sender: UIButton) {
        getLocationInfos()
        print(address)
    }

}

extension RegisterLocationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
}

