//
//  OfferViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 26/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class OfferViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setCancelButton()
    }
    
    @IBAction func offerPressed(_ sender: UIButton) {
        isOffering = true
    }
    
}
