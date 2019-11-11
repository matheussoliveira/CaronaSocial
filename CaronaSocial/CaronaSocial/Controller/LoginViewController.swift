//
//  LoginViewController.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 04/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        emailField.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1).cgColor
    }
    
    @IBAction func registragionButton(_ sender: Any) {
        FirebaseAuthManager().createUser(email: emailField.text!, password: passwordField.text!) {
                [weak self] (success) in
                guard let self = self else { return }
                var message: String = ""
                if (success) {
                message = "User was sucessfully created."
                self.navigationController?.dismiss(animated: true)
                } else {
                message = "There was an error."
            }
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true)
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if ( ( emailField.text != nil) && (passwordField.text != nil)) {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
              // ...
                print("Funcionou")
            }
        } else { print("Oloko") }
    }
    
    
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
