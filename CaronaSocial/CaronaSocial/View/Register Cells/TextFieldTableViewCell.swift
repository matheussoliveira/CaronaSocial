//
//  TextFieldTableViewCell.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 19/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var cellTextField: UITextField!
    
//    weak var delegate: CellTextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellTextField.delegate = self
        
//        cellTextField.addTarget(self, action: #selector(textFieldTapped), for: .touchDown)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }

}

extension TextFieldTableViewCell: StatePickerSelectedDelegate {
    func selectedState(state: String) {
        cellTextField.text = state
    }
}

extension TextFieldTableViewCell: SeatsPickerSelectedDelegate {
    func selectedSeat(seat: String) {
        cellTextField.text = seat
    }
}

extension TextFieldTableViewCell: WheelchairPickerSelectedDelegate {
    func selectedWheelchair(wheelchair: String) {
        cellTextField.text = wheelchair
    }
}
