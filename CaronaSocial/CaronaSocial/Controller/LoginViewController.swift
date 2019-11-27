//
//  LoginViewController.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 04/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit
import Foundation
import FirebaseUI
import FirebaseDatabase
import Firebase
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // Database test

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        UIApplication.shared.statusBarStyle = .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    @IBAction func registragionButton(_ sender: Any) {
        FirebaseManager().createUser(email: emailField.text!, password: passwordField.text!) {
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
    
    
    @IBAction func home(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
    }
    
    
}

// Put this piece of code anywhere you like
//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}
