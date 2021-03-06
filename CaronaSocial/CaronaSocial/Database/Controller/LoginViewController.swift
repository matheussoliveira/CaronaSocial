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
    
    // This is not secure, but it will prevent us
    // for making loging everytime
    let userDefault = UserDefaults.standard
    let launchedBefore = UserDefaults.standard.bool(forKey: "usersignedin")
    
    // Database test

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.statusBarStyle = .darkContent
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationController?.navigationItem.leftBarButtonItems = []
        self.navigationController?.navigationItem.hidesBackButton = true
        if userDefault.bool(forKey: "usersignedin") {
              performSegue(withIdentifier: "goToHome", sender: self)
          }
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
            // TODO: Handle login error
            
            Auth.auth().signIn(withEmail: self.emailField.text!,
                               password: self.passwordField.text!) { (user, error) in
                if error == nil {
                    
                    self.userDefault.set(true, forKey: "usersignedin")
                    self.userDefault.synchronize()
                    self.performSegue(withIdentifier: "goToHome", sender: nil)
                } else {
                    print(error!.localizedDescription)
                }
            }
        } else {
            // TODO: Handle empty fields
            
            print("Fields vazios!")
        }
    }
    
    
    @IBAction func home(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
    }
    
    @IBAction func backToLogin(_ sender: UIStoryboardSegue) {
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
