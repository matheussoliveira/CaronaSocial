//
//  RideTableViewCell.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 04/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class RideTableViewCell: UITableViewCell {

    @IBOutlet weak var riderName: UILabel!
    @IBOutlet weak var places: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
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
