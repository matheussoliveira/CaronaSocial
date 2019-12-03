//
//  EditRoteTableViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 27/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class EditRoteTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var start: UITextField!
    @IBOutlet weak var departureTime: UITextField!
    @IBOutlet weak var destiny: UITextField!
    @IBOutlet weak var arrivalTime: UITextField!
    
    var startText: String?
    var destinyText: String?
    var rote: MatchsTableViewController?
    var selectedHour: String = ""
    var selectedMinute: String = ""
    var selectedField: String?
    
    var hours = ["01", "02", "03", "04", "05", "06", "07", "08",
                 "09", "10", "11", "12", "13", "14", "15", "16",
                 "17", "18", "19", "20", "21", "22", "23", "00"]
    
    var minutes = ["00", "01", "02", "03", "04", "05", "06", "07",
                   "08", "09", "10", "11", "12", "13", "14", "15",
                   "16", "17", "18", "19", "20", "21", "22", "23",
                   "24", "25", "26", "27", "28", "29", "30", "31",
                   "32", "33", "34", "35", "36", "37", "38", "39",
                   "40", "41", "42", "42", "43", "44", "45", "46",
                   "47", "48", "49", "50", "51", "52", "53", "54",
                   "55", "56", "57", "58", "59"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let datePicker = UIPickerView()
        datePicker.delegate = self
        datePicker.dataSource = self
        departureTime.inputView = datePicker
        arrivalTime.inputView = datePicker
        showDatePicker()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        start.text = startText
        destiny.text = destinyText
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Sending information to MatchesTableViewController
        if segue.identifier == "1" {
            if let adressVC = segue.destination as? EditRoteTableViewController {
                adressVC.startText = sender as? String
            }
        }
        
        if segue.identifier == "2" {
            if let adressVC = segue.destination as? EditRoteTableViewController {
                adressVC.destinyText = sender as? String
            }
        }
        
        // Getting selected field and updating
        // our flag in AddressTableViewController
        if let addressVC = segue.destination as? AddressTableViewController {
            addressVC.fieldFlag = self.selectedField
        }
    }
    
    // MARK: - Keyboard toolbar
    
    @objc func doneConditionPicker() {
        self.view.endEditing(true)
    }

    @IBAction func backToEditRote(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func confirmButton(_ sender: Any) {
//        rote?.addRote(rote: Rote(start: start.text ?? "",
//                                 destiny: destiny.text ?? "",
//                                 departure: departureTime.text ?? "",
//                                 arrival: arrivalTime.text ?? "" ))
        performSegue(withIdentifier: "backToMatch", sender: self)
    }
    
    // MARK: - Hour picker view
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return hours.count
        } else if component == 1 {
            return minutes.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        if component == 0 {
           return  hours[row]
        } else if component == 1 {
            return minutes[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        
        if departureTime.isFirstResponder {
            if component == 0 {
                selectedHour = hours[row]
            } else if component == 1 {
                selectedMinute = minutes[row]
            }
            departureTime.text = "\(selectedHour):\(selectedMinute)"
        } else if arrivalTime.isFirstResponder {
        if component == 0 {
            selectedHour = hours[row]
        } else if component == 1 {
            selectedMinute = minutes[row]
        }
        arrivalTime.text = "\(selectedHour):\(selectedMinute)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(50.0)
    }
    
    func showDatePicker() {
        
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
        
        departureTime.inputAccessoryView = toolbar
        arrivalTime.inputAccessoryView = toolbar
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0) {
            self.selectedField = "start"
            performSegue(withIdentifier: "selectDestiny", sender: nil)
        } else if (indexPath.row == 1) {
            self.selectedField = "destiny"
            performSegue(withIdentifier: "selectDestiny", sender: nil)
        }
        
    }
}
