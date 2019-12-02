//
//  Auxiliary.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 18/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // Scroll when keyboard hide text field
    @objc func keyboardWillShow(_ notification: Notification, tableView: UITableView) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            //Keyboard size
            let keyboardRectangle = keyboardFrame.cgRectValue
            let kbSize = keyboardRectangle.size.height
            guard let currentTextField = view.getSelectedTextField() else {
                return
            }
            
            if notification.name == UIResponder.keyboardDidShowNotification ||
                notification.name == UIResponder.keyboardWillChangeFrameNotification {
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize, right: 0)
                
                tableView.contentInset = contentInsets
                tableView.scrollIndicatorInsets = contentInsets
                
                var aRect = self.view.frame
                aRect.size.height -= kbSize
                
                if aRect.contains(currentTextField.frame.origin) {
                    let tableViewY = tableView.frame.origin.y
                    
                    let frame = CGRect(x: currentTextField.frame.origin.x,
                                       y: currentTextField.frame.origin.y - tableViewY,
                                       width: currentTextField.frame.width,
                                       height: currentTextField.frame.height)
    
                    tableView.scrollRectToVisible(frame, animated: true)
                }
            }
            
            if notification.name == UIResponder.keyboardWillHideNotification {
                let contentInsets = UIEdgeInsets.zero
                
                tableView.contentInset = contentInsets
                tableView.scrollIndicatorInsets = contentInsets
            }
        }
    }
    
    func removeCellSeparatorLines(_ cell: UITableViewCell) {
        // Remove the lines from the cell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell.selectionStyle = .none
    }
    
}

extension UIView {
    func getSelectedTextField() -> UITextField? {
        
        let totalTextFields = getTextFieldsInView(view: self)
        
        for textField in totalTextFields{
            if textField.isFirstResponder{
                return textField
            }
        }
        
        return nil
        
    }
    
    func getTextFieldsInView(view: UIView) -> [UITextField] {
        
        var totalTextFields = [UITextField]()
        
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                totalTextFields += [textField]
            } else {
                totalTextFields += getTextFieldsInView(view: subview)
            }
        }
        
        return totalTextFields
    }
}

//Vibrate the device
extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

extension UIViewController {
    // Lack of input feedback
    //Shake a textField when detect an error input
    func shakeTextField(textField: UITextField, for duration: TimeInterval, placeholder: String) {
        let normalColor = textField.textColor
        
        let translation: CGFloat = 10
        
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            textField.transform = CGAffineTransform(translationX: translation, y: 0)
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            textField.textColor = .red
        }
        
        propertyAnimator.addAnimations({textField.transform = CGAffineTransform(translationX: 0, y: 0)}, delayFactor: 0.2)
        
        propertyAnimator.addCompletion { (_) in
            textField.layer.borderWidth = 0
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            textField.textColor = normalColor
        }
        
        propertyAnimator.startAnimation()
        
        //Vibrate
        UIDevice.vibrate()
    }
    
    //Shake a label when detect an error input
    func shakeLabel(label: UILabel, for duration: TimeInterval) {
        let normalColor = label.textColor
        
        let translation: CGFloat = 10
        
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            label.transform = CGAffineTransform(translationX: translation, y: 0)
            label.textColor = .red
        }
        
        propertyAnimator.addAnimations({label.transform = CGAffineTransform(translationX: 0, y: 0)}, delayFactor: 0.2)
        
        propertyAnimator.addCompletion { (_) in
            label.layer.borderWidth = 0
            label.textColor = normalColor
        }
        
        propertyAnimator.startAnimation()
        
        //Vibrate
        UIDevice.vibrate()
    }
    
    //Shake a button when detect an error input
    func shakeButton(button: UIButton, for duration: TimeInterval) {
        let normalColor = button.tintColor
        
        let translation: CGFloat = 10
        
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            button.transform = CGAffineTransform(translationX: translation, y: 0)
            button.tintColor = .red
        }
        
        propertyAnimator.addAnimations({button.transform = CGAffineTransform(translationX: 0, y: 0)}, delayFactor: 0.2)
        
        propertyAnimator.addCompletion { (_) in
            button.layer.borderWidth = 0
            button.tintColor = normalColor
        }
        
        propertyAnimator.startAnimation()
        
        //Vibrate
        UIDevice.vibrate()
    }
}
