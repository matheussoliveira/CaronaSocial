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
    var user: EmployeeDriverModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setCancelButton()
    }
    
    @IBAction func offerPressed(_ sender: UIButton) {
        isOffering = true
    }
    
    @IBAction func seekPressed(_ sender: UIButton) {
        isOffering = false
    }
}
