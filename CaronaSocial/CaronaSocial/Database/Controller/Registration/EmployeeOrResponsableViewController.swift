//
//  EmployeeOrResponsableViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 26/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//
import UIKit

class EmployeeOrResponsableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Changing status bar color
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.customBlue
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    @IBAction func employeeButton(_ sender: UIButton) {
        registerScreen = 0
    }
    
    @IBAction func responsableButton(_ sender: UIButton) {
        registerScreen = 1
    }

}
