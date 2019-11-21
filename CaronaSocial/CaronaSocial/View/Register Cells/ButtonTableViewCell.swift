//
//  ButtonTableViewCell.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 19/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellButton: UIButton!
    
    weak var delegate: ContinueDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        delegate?.continueButton()
    }

}
