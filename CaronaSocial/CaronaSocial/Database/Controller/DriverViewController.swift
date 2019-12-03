
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
    @IBOutlet weak var origin: UILabel!
    var driver: DriverModel?
    var newImage: UIImage?
    var ride: RideModel?
    
    @IBOutlet weak var destiny: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        profileImage.image = newImage
        profileImage.makeRounded()
        name.text = driver?.name
        vacantyNumber.text = driver?.vacantPlaces
        accessibility.text = driver?.accessibility ?? false ? "Sim" : "Não"
        observation.text = driver?.observation ?? "Sem informações"
        vacantyNumber.text = self.ride?.vacant
        accessibility.text = self.ride?.accessibility
        observation.text = self.ride?.observation
        origin.text = self.ride?.origin
        destiny.text = self.ride?.destiny
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Teste: \(driver?.name)")
    }
    
    
}
