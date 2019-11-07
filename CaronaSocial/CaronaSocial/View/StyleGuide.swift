//
//  Extensions.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 07/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import UIKit

//Colors
struct Colors {
    let textFieldBottomLine = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
}

//Put bottom line in a text field
extension UITextField {
    func setBottomBorder(color: String) {
        self.borderStyle = UITextField.BorderStyle.none
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(named: color)!.cgColor
        border.frame = CGRect(x: 0,
                              y: self.frame.size.height - width,
                              width:  self.frame.size.width,
                              height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

//Change Corner Radius, Border Width and Border Color of buttons in the storyboard
extension UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}

