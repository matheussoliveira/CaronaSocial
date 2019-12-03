//
//  TextFieldTableViewCell.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 19/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTextField: UITextField!
    
//    weak var delegate: CellTextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        cellTextField.addTarget(self, action: #selector(textFieldTapped), for: .touchDown)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TextFieldTableViewCell: PickerSelectedDelegate {
    func selectedState(state: String) {
        cellTextField.text = state
    }
}

