//
//  TextViewTableViewCell.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 04/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var cellTextView: UITextView!
    @IBOutlet weak var temporaryTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        temporaryTextField.delegate = self
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
