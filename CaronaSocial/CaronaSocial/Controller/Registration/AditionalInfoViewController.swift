//
//  AditionalInfoViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 29/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class AditionalInfoViewController: UIViewController {
    
    @IBOutlet weak var progressImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if registerScreen == 0 {
            progressImage.image = UIImage(named: "progress24")
        } else {
            progressImage.image = UIImage(named: "progress5")
        }
    }

}
