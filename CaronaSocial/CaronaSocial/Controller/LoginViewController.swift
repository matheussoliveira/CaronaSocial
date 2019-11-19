//
//  LoginViewController.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 04/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    public var registerScreenNumber: Int = 0
    public static let shared = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        
        emailField.setBottomBorder(color: .textFieldBottomLine)
        passwordField.setBottomBorder(color: .textFieldBottomLine)
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        //Check email and password to login
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "register" {
            registerScreenNumber = 1
        }
    }
    

}
