//
//  OfferViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 26/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class OfferViewController: UIViewController {
    
    var user: EmplyeeDriverModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Oooo eu aqui \(user?.name)")
    }
    
    @IBAction func proceed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
        let newRegisterViewController = storyBoard.instantiateViewController(withIdentifier: "FixLocations") as! FixLocationsViewController
        newRegisterViewController.user = self.user // Sending user to next view to proceed with registration
        self.navigationController?.pushViewController(newRegisterViewController, animated: true)
    }

}
