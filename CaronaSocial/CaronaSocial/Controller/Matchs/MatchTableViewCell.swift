//
//  MatchTableViewCell.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 18/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    @IBOutlet weak var rideName: UILabel!
    @IBOutlet weak var rideNumber: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
