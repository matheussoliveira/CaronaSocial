//
//  DriverViewController.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 27/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class DriverViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var vacantyNumber: UILabel!
    @IBOutlet weak var accessibility: UILabel!
    @IBOutlet weak var observation: UITextView!
    
    var driver: DriverModel?
    var newImage: UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        profileImage.image = newImage
        profileImage.makeRounded()
        name.text = driver?.name
        vacantyNumber.text = driver?.vacantPlaces
        accessibility.text = driver?.accessibility ?? false ? "Sim" : "Não"
        observation.text = driver?.observation ?? "Sem informações"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Teste: \(driver?.name)")
    }
    
    
}
