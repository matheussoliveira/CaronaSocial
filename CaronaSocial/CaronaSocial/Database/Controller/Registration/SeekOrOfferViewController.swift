//
//  SeekOrOfferViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 21/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class SeekOrOfferViewController: UIViewController {
    
    // Employee data
    var responsable: ResponsableModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Seek or offer: \(responsable?.responsableName)")

        setCancelButton()
    }
    

    @IBAction func offerButton(_ sender: Any) {
        self.responsable?.type = "driver"
       performSegue(withIdentifier: "goToFixLocations", sender: nil)
    }
    
    @IBAction func seekButton(_ sender: Any) {
        self.responsable?.type = "passenger"
        performSegue(withIdentifier: "goToFixLocations", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFixLocations" {
            if let newVC = segue.destination as? FixLocationsViewController {
                newVC.responsable = self.responsable
            }
        }
    }
}
