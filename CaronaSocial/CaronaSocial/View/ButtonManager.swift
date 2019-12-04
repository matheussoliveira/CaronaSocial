//
//  ButtonManager.swift
//  CaronaSocial
//
//  Created by Marina Miranda Aranha on 04/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import UIKit

class ButtonManager: UIViewController {
    
    // Design of a selected button
    func selectedButtonDesign(button: UIButton) {
        button.isSelected = true
        button.backgroundColor = .systemOrange
        button.tintColor = .clear
        button.setTitleColor(.white, for: .selected)
        button.image(for: .selected)
    }
    
    // Design of a button not selected
    func notSelectedButtonDesign(button: UIButton) {
        button.isSelected = false
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.setTitleColor(.systemOrange, for: .normal)
        button.image(for: .normal)
    }
    
}
