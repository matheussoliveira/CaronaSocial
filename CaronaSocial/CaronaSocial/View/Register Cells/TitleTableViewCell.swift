//
//  TitleTableViewCell.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 19/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class TitleTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var cellPlaceholder: UILabel!
    @IBOutlet weak var cellSkyTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var cellIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellSkyTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
