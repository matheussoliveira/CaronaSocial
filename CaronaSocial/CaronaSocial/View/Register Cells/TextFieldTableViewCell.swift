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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

extension TextFieldTableViewCell: PickerSelectedDelegate {
    func selectedState(state: String) {
        cellTextField.text = state
    }
}

