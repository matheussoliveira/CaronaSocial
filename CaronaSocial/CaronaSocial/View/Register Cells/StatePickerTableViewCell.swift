//
//  PickerTableViewCell.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 27/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

protocol StatePickerSelectedDelegate: NSObjectProtocol {
    func selectedState(state: String)
}

class StatePickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellPicker: UIPickerView!
    
    let states = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"]
    var selectedState: String = ""
    weak var pickerDelegate: StatePickerSelectedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellPicker.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension StatePickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
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
        
        selectedState = states[row]
        pickerDelegate?.selectedState(state: selectedState)
    }
    
}
