//
//  EditRoteTableViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 27/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class EditRoteTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var start: SkyFloatingLabelTextField!
    @IBOutlet weak var departureTime: SkyFloatingLabelTextField!
    @IBOutlet weak var destiny: SkyFloatingLabelTextField!
    @IBOutlet weak var arrivalTime: SkyFloatingLabelTextField!
    @IBOutlet weak var seats: SkyFloatingLabelTextField!
    @IBOutlet weak var wheelchair: SkyFloatingLabelTextField!
    @IBOutlet weak var aditionalInfo: UITextView!
    @IBOutlet weak var aditionalInfoPlaceholder: UILabel!
    
    var isOffering: Bool = false
    
    var startText: String?
    var destinyText: String?
    var rote: MatchsTableViewController?
    var selectedHour: String = ""
    var selectedMinute: String = ""
    var selectedField: String?
    
    var selectedNumberofSeats: String = ""
    var selectedWheelchair: String = ""
    
    var newRide: RideModel?
    var userID: String?

    var hours = ["00", "01", "02", "03", "04", "05", "06", "07", "08",
                 "09", "10", "11", "12", "13", "14", "15", "16",
                 "17", "18", "19", "20", "21", "22", "23"]

    var minutes = ["00", "01", "02", "03", "04", "05", "06", "07",
                   "08", "09", "10", "11", "12", "13", "14", "15",
                   "16", "17", "18", "19", "20", "21", "22", "23",
                   "24", "25", "26", "27", "28", "29", "30", "31",
                   "32", "33", "34", "35", "36", "37", "38", "39",
                   "40", "41", "42", "42", "43", "44", "45", "46",
                   "47", "48", "49", "50", "51", "52", "53", "54",
                   "55", "56", "57", "58", "59"]

    var numberOfSeats = ["1", "2", "3", "4"]
    var wheelchairAvailable = ["Sim", "Não"]
    
    let datePicker = UIPickerView()
    let seatsPicker = UIPickerView()
    let wheelchairPicker = UIPickerView()
    var userType: String?
    var period: String?
    var day: String?
    var inputErrorDetected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.delegate = self
        datePicker.dataSource = self
        departureTime.inputView = datePicker
        arrivalTime.inputView = datePicker
        
        seatsPicker.delegate = self
        seatsPicker.dataSource = self
        seats.inputView = seatsPicker
        
        wheelchairPicker.delegate = self
        wheelchairPicker.dataSource = self
        wheelchair.inputView = wheelchairPicker
        
        showPicker()
        
        hideKeyboardWhenTappedAround()
        
        aditionalInfo.delegate = self
        aditionalInfoPlaceholder.isHidden = !aditionalInfo.text.isEmpty
        
        //Keyboard Events
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(allowRowSelection), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        //Changing status bar color
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.customBlue
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        start.text = startText
        destiny.text = destinyText
        
        departureTime.title = ""
        arrivalTime.title = ""
        departureTime.textAlignment = .center
        arrivalTime.textAlignment = .center
        
        if isOffering == true {
            seats.placeholder = "Número de lugares disponíveis"
            wheelchair.placeholder = "Existe espaço para cadeirante?"
        } else {
            seats.placeholder = "Número de passageiros"
            wheelchair.placeholder = "Algum passageiro é cadeirante?"
        }
    
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
        let group = DispatchGroup()
        
        checkInputInfo() { result in
            if self.inputErrorDetected == false {

                group.enter()
                FirestoreManager.shared.setDailyRide(userID: self.userID!, userType: self.userType!, period: self.period!, day: self.day!, newRide: self.newRide!){ result in
                    group.leave()
                }
                
                group.notify(queue: .main){
                    print("Finish")
                    self.performSegue(withIdentifier: "backToMatch", sender: self)
                }
                //            navigationController?.popViewController(animated: true)
            }
        }

    }
    
    func checkInputInfo(completionHandler: @escaping (String) -> Void) {
        let group = DispatchGroup()
        let textFields = [start, destiny, departureTime, arrivalTime, seats, wheelchair]
        
        for textField in textFields {
            let placeholder = textField?.placeholder ?? ""
            if textField?.text?.isEmpty ?? false {
                shakeTextField(textField: textField!, for: 1.0, placeholder: placeholder, textColor: .black)
            }
        }
        
        if start.text?.isEmpty ?? false || destiny.text?.isEmpty ?? false || departureTime.text?.isEmpty ?? false || arrivalTime.text?.isEmpty ?? false || seats.text?.isEmpty ?? false || wheelchair.text?.isEmpty ?? false {
            inputErrorDetected = true
            completionHandler("False")
            
        } else {
            inputErrorDetected = false
            
            var originInfo: LocationModel?
            var destinyInfo: LocationModel?
            
            group.enter()
            FirestoreManager.shared.fetchLocation(location: start.text!) { result in
                originInfo = result
                group.enter()
                FirestoreManager.shared.fetchLocation(location: self.destiny.text!) { result in
                    destinyInfo = result
                    self.userID = FirebaseManager.shared.getUserID()
                    group.leave()
                }
                group.leave()
            }
            
            let timeFormat = "\(textFields[2]!.text!)" + "-" + "\(textFields[3]!.text!)"
            
            group.notify(queue: .main) {
                
                self.newRide = RideModel(userID: self.userID!, time: timeFormat, origin: originInfo!.address, destiny: destinyInfo!.address, originPoint: Point(latitude: originInfo!.latitude, longitude: originInfo!.longitude), destinyPoint: Point(latitude: destinyInfo!.latitude, longitude: destinyInfo!.longitude), vacant: textFields[4]!.text!, accessibility: (textFields[5]?.text!)!, observation: "", originType: (textFields[0]?.text!)!, destinyType: (textFields[1]?.text!)!, requestedArray: [])
                 completionHandler("Done")
                
            }
        }
        
    }
    
    // MARK: -  Picker view
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        if pickerView == datePicker {
            if component == 0 {
                return hours.count
            } else {
                return minutes.count
            }
        } else if pickerView == seatsPicker {
            return numberOfSeats.count
        } else if pickerView == wheelchairPicker {
            return wheelchairAvailable.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if pickerView == datePicker {
            if component == 0 {
               return  hours[row]
            } else if component == 1 {
                return minutes[row]
            }
        } else if pickerView == seatsPicker {
            return numberOfSeats[row]
        } else if pickerView == wheelchairPicker {
            return wheelchairAvailable[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        
        if pickerView == datePicker {
            if departureTime.isFirstResponder {
                if component == 0 {
                    selectedHour = hours[row]
                } else if component == 1 {
                    selectedMinute = minutes[row]
                }
                
                if selectedHour == "" {
                    selectedHour = "00"
                }
                if selectedMinute == ""{
                    selectedMinute = "00"
                }
                
                departureTime.text = "\(selectedHour):\(selectedMinute)"
            } else if arrivalTime.isFirstResponder {
                
                if component == 0 {
                    selectedHour = hours[row]
                } else if component == 1 {
                    selectedMinute = minutes[row]
                }
                
                if selectedHour == "" {
                    selectedHour = "00"
                }
                if selectedMinute == ""{
                    selectedMinute = "00"
                }
                
                arrivalTime.text = "\(selectedHour):\(selectedMinute)"
            }
        } else if pickerView == seatsPicker {
            if seats.isFirstResponder {
                selectedNumberofSeats = numberOfSeats[row]
            }
            seats.text = selectedNumberofSeats
        } else if pickerView == wheelchairPicker {
            if wheelchair.isFirstResponder {
                selectedWheelchair = wheelchairAvailable[row]
            }
            wheelchair.text = selectedWheelchair
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if pickerView == datePicker {
            return CGFloat(50.0)
        } else {
            return CGFloat(80.0)
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == datePicker {
            return 2
        } else {
            return 1
        }
    }
    
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
        
        departureTime.inputAccessoryView = toolbar
        arrivalTime.inputAccessoryView = toolbar
        seats.inputAccessoryView = toolbar
        wheelchair.inputAccessoryView = toolbar
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            self.selectedField = "start"
            performSegue(withIdentifier: "selectDestiny", sender: nil)
        } else if indexPath.row == 1 {
            self.selectedField = "destiny"
            performSegue(withIdentifier: "selectDestiny", sender: nil)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 78

        switch indexPath.row {
        case 2:
            height = 88
        case 3:
            height = 88
        case 6:
            height = 36 + aditionalInfo.frame.height
        default:
            height = 68
        }

        return height
    }
    
    // MARK: TextView
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //Dismiss keyboard when return key is tapped
        if text == "\n" {
            aditionalInfo.resignFirstResponder()
            return false
        }
        
        //Limit number of characters
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return changedText.count <= 150
    }

    
    func textViewDidChange(_ textView: UITextView) {
        //Hide placeholder when textView isn't empty
        aditionalInfoPlaceholder.isHidden = !aditionalInfo.text.isEmpty
        
        // Resize text view
        let lastScrollOffset = tableView.contentOffset
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.layer.removeAllAnimations()
        tableView.setContentOffset(lastScrollOffset, animated: false)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tableView.allowsSelection = false
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            //Keyboard size
            let keyboardRectangle = keyboardFrame.cgRectValue
            let kbSize = keyboardRectangle.size.height
            
            if notification.name == UIResponder.keyboardDidShowNotification ||
                notification.name == UIResponder.keyboardWillChangeFrameNotification {
                
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize, right: 0)
                
                self.tableView.contentInset = contentInsets
                self.tableView.scrollIndicatorInsets = contentInsets
                
                var aRect = self.view.frame
                aRect.size.height -= kbSize
                
                if let currentTextView = view.getSelectedTextView() {
                    if aRect.contains(currentTextView.frame.origin) {
                        
                        let tableViewY = tableView.frame.origin.y
                        
                        let convertedTextView = currentTextView.convert(currentTextView.frame.origin, to: self.view)
                        
                        let frame = CGRect(x: convertedTextView.x,
                                           y: convertedTextView.y - tableViewY,
                                           width: currentTextView.frame.width,
                                           height: currentTextView.frame.height)
                        
                        self.tableView.scrollRectToVisible(frame, animated: true)
                    }
                }
                
            }
            
            if notification.name == UIResponder.keyboardWillHideNotification {
                
                let contentInsets = UIEdgeInsets.zero
                
                self.tableView.contentInset = contentInsets
                self.tableView.scrollIndicatorInsets = contentInsets
            }
            
        }
    }
    
    @objc func allowRowSelection(_ notification: NSNotification) {
        if notification.name == UIResponder.keyboardDidHideNotification {
            tableView.allowsSelection = true
        }
    }
}
