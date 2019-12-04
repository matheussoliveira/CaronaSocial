//
//  AditionalInfoViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 29/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class AditionalInfoViewController: UIViewController {
    
    @IBOutlet weak var finishButton: UIButton!
    
    var seatsCell: TextFieldTableViewCell!
    var seatsPickerCell: SeatsPickerTableViewCell!
    let seatsAvailable = ["1", "2", "3", "4"]
    var isSeatPickerHidden: Bool = true
    var seatPickerCellHeight: CGFloat = 0
    
    var wheelchairCell: TextFieldTableViewCell!
    var wheelchairPickerCell: WheelchairPickerTableViewCell!
    let wheelchairAvailable = ["Sim", "Não"]
    var isWheelchairPickerHidden: Bool = true
    var wheelchairPickerCellHeight: CGFloat = 0
    
    var isSeatsPicker: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCancelButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func finishPressed(_ sender: UIButton) {
        let title = "Cadastro finalizado!"
        let msg = "Para entrar no aplicativo é preciso verificar seu endereço de email. Por favor confira sua caixa de entrada e siga as instruções no email que enviamos."
        
        displayMsg(title : title, msg : msg, style: .alert)
    }
    
    //Alert message
    func displayMsg(title : String, msg : String, style: UIAlertController.Style = .alert) {
        
        let ac = UIAlertController.init(title: title,
                                        message: msg,
                                        preferredStyle: style)
        
        //GET INFO HERE
        ac.addAction(UIAlertAction.init(title: "OK",
                                        style: .default,
                                        handler: {(action: UIAlertAction!) in
                                            self.performSegue(withIdentifier: "backToLogin", sender: self)
        }))
        
    
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
        }
    }

}

extension AditionalInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: //progress image
            let cell = tableView.dequeueReusableCell(withIdentifier: "progress", for: indexPath) as! ImageTableViewCell
            if registerScreen == 0 {
                cell.cellImage.image = UIImage(named: "progress24")
            } else {
                cell.cellImage.image = UIImage(named: "progress5")
            }
            removeCellSeparatorLines(cell)
            return cell
        case 1: //number of seats available
            self.seatsCell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as? TextFieldTableViewCell
            let cell = self.seatsCell
            var placeholder: String = ""
            
            if isOffering == true {
                placeholder = "Número de lugares disponíveis"
            } else {
                placeholder = "Número de passageiros"
            }
    
            cell?.cellTextField.placeholder = placeholder
            cell?.cellTextField.isUserInteractionEnabled = false
            return cell!
        case 2: //picker of number of seats
            self.seatsPickerCell = tableView.dequeueReusableCell(withIdentifier: "seatsPicker", for: indexPath) as? SeatsPickerTableViewCell
            let cell = self.seatsPickerCell
            
            //Picker delegate
            self.seatsPickerCell.pickerDelegate = self.seatsCell
            
            return cell!
        case 3: //weelchair
            self.wheelchairCell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as? TextFieldTableViewCell
                    let cell = self.wheelchairCell
                    var placeholder: String = ""
                    
                    if isOffering == true {
                        placeholder = "Existe espaço para cadeirante?"
                    } else {
                        placeholder = "Algum passageiro é cadeirante?"
                    }
            
                    cell?.cellTextField.placeholder = placeholder
                    cell?.cellTextField.isUserInteractionEnabled = false
                    return cell!
        case 4: //picker weelchair
            self.wheelchairPickerCell = tableView.dequeueReusableCell(withIdentifier: "wheelchairPicker", for: indexPath) as? WheelchairPickerTableViewCell
            let cell = self.wheelchairPickerCell
            
            //Picker delegate
            self.wheelchairPickerCell.pickerDelegate = self.wheelchairCell
            
            return cell!
        case 5: //label add info
            let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelTableViewCell
            cell.cellLabel.text = "Acrescentar observações (opcional)"
            return cell
        case 6: //textview add info
            let cell = tableView.dequeueReusableCell(withIdentifier: "textView", for: indexPath) as! TextViewTableViewCell
            return cell
        case 8: //finish registration button
            let cell = tableView.dequeueReusableCell(withIdentifier: "button", for: indexPath) as! ButtonTableViewCell
            removeCellSeparatorLines(cell)
            return cell
        default: //blank cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "blank", for: indexPath)
            removeCellSeparatorLines(cell)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let seatTextFieldIndexPath = IndexPath(row: 1, section: 0)
        let wheelchairTextFieldIndexPath = IndexPath(row: 3, section: 0)
        
        if seatTextFieldIndexPath == indexPath {
            isSeatPickerHidden = !isSeatPickerHidden
            
            if isSeatPickerHidden == false {
                seatPickerCellHeight = 140
            } else {
                seatPickerCellHeight = 0
            }
            
            tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
        }
        
        if wheelchairTextFieldIndexPath == indexPath {
            isWheelchairPickerHidden = !isWheelchairPickerHidden
            
            if isWheelchairPickerHidden == false {
                wheelchairPickerCellHeight = 140
            } else {
                wheelchairPickerCellHeight = 0
            }
            
            tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .fade)
        }
        
    }
    

}

extension AditionalInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isSeatsPicker == true {
            return seatsAvailable.count
        } else {
            return wheelchairAvailable.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isSeatsPicker == true {
            return seatsAvailable[row]
        } else {
            return wheelchairAvailable[row]
        }
    }
    
}
