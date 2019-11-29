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
    
    var adress: String?
    var rote: MatchsTableViewController?
    
    var selectedHour: String = ""
    var selectedMinute: String = ""
    
    var hours =
        ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","00"]
    
    var minutes = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIPickerView()
        
        datePicker.delegate = self
        datePicker.dataSource = self
        
        departureTime.inputView = datePicker

        arrivalTime.inputView = datePicker
        
        showDatePicker()
        
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = UIDatePicker.Mode.time
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
//
//        view.addGestureRecognizer(tapGesture)
//
//        departureTime.inputView = datePicker
    }
    
    func showDatePicker(){
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelConditionPicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(doneConditionPicker));
        
        toolbar.tintColor = #colorLiteral(red: 0.7607844472, green: 0.235294193, blue: 0.5333334208, alpha: 1)
        toolbar.setItems([spaceButton,cancelButton], animated: false)
        
        departureTime.inputAccessoryView = toolbar
        arrivalTime.inputAccessoryView = toolbar
    }
    
    @objc func doneConditionPicker(){
        self.view.endEditing(true)
    }
    
//    @objc func cancelConditionPicker(){
//        self.view.endEditing(true)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        start.text = adress

    }

    // MARK: - Table view data source
    
    @IBAction func backToEditRote(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        
        rote?.addRote(rote: Rote(start: start.text ?? "",
                                 destiny: destiny.text ?? "",
                                 departure: departureTime.text ??  "",
                                 arrival: arrivalTime.text ?? "" ))
        
        performSegue(withIdentifier: "backToMatch", sender: self)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return hours.count
        } else if component == 1 {
            return minutes.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
           return  hours[row]
        } else if component == 1 {
            return minutes[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if departureTime.isFirstResponder{
            if component == 0 {
                selectedHour = hours[row]
            } else if component == 1 {
                selectedMinute = minutes[row]
            }
            departureTime.text = "\(selectedHour):\(selectedMinute)"
        } else if arrivalTime.isFirstResponder{
        if component == 0 {
            selectedHour = hours[row]
        } else if component == 1 {
            selectedMinute = minutes[row]
        }
        arrivalTime.text = "\(selectedHour):\(selectedMinute)"
        }
    }

}
