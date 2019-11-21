//
//  LabelTableViewCell.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 21/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
