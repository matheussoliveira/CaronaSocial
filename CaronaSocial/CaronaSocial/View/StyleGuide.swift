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
extension UIColor {
    static let textFieldBottomLine: UIColor = #colorLiteral(red: 0.6666666667, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    static let customBlue: UIColor = #colorLiteral(red: 0.1137254902, green: 0.4470588235, blue: 1, alpha: 1)
    static let customBackground: UIColor = #colorLiteral(red: 0.9599999785, green: 0.9599999785, blue: 0.9599999785, alpha: 1)
}

//Put bottom line in a text field
extension UITextField {
    func setBottomBorder(color: UIColor) {
        self.borderStyle = UITextField.BorderStyle.none
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
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

