//
//  SeekOrOfferViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 21/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class SeekOrOfferViewController: UIViewController {
    
    var institutionName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCancelButton()
    }
    
    @IBAction func offerPressed(_ sender: UIButton) {
        isOffering = true
        let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FixLocation") as! FixLocationsViewController
        vc.institutionAddress = institutionName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func seekPressed(_ sender: UIButton) {
        isOffering = false
        let storyBoard: UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FixLocation") as! FixLocationsViewController
        vc.institutionAddress = institutionName
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
