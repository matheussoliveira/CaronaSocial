//
//  WheelchairPickerTableViewCell.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 04/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

protocol WheelchairPickerSelectedDelegate: NSObjectProtocol {
    func selectedWheelchair(wheelchair: String)
}

class WheelchairPickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellPicker: UIPickerView!
    
    let wheelchair = ["Sim", "Não"]
    var selectedWheelchair: String = ""
    weak var pickerDelegate: WheelchairPickerSelectedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellPicker.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension WheelchairPickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return wheelchair.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return wheelchair[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedWheelchair = wheelchair[row]
        pickerDelegate?.selectedWheelchair(wheelchair: selectedWheelchair)
    }
    
}
