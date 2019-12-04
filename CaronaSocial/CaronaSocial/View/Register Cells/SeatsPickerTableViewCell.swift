//
//  SeatsPickerTableViewCell.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 04/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

protocol SeatsPickerSelectedDelegate: NSObjectProtocol {
    func selectedSeat(seat: String)
}

class SeatsPickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellPicker: UIPickerView!
    
    let seats = ["1", "2", "3", "4"]
    var selectedSeat: String = ""
    weak var pickerDelegate: SeatsPickerSelectedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellPicker.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension SeatsPickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return seats.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return seats[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedSeat = seats[row]
        pickerDelegate?.selectedSeat(seat: selectedSeat)
    }
    
}
