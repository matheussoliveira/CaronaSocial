//
//  DriverMatchTableViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 05/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class DriverMatchTableViewController: UITableViewController {
    
    var driver: UserModel?
    var newImage: UIImage?
    var ride: RideModel?
    var day: String?
    var period: String?
    var selectedDriver: RideModel?
    //var requestedArray: [String]?
    var userID: String?
    var state: Bool = false

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var vacantyNumber: UILabel!
    @IBOutlet weak var accessibility: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var destiny: UILabel!
    @IBOutlet weak var observation: UITextView!
    @IBOutlet weak var requestedButton: UIButton!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        self.tableView.reloadData()
        print(day ?? "Dia nao veio")
        print(period ?? "Periodo nao veio") 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImage.image = newImage
        profileImage.makeRounded()
        name.text = driver?.name
//        vacantyNumber.text = self.ride?.vacant
        vacantyNumber.text = "2"

        accessibility.text = "Não"
        observation.text = self.ride?.observation
        origin.text = self.ride?.origin
        destiny.text = self.ride?.destiny
        
        self.userID = ride?.userID ?? "error"
        
//        //requestedArray = FirestoreManager.shared.checkResquestedRide(driverID: self.selectedDriver!.userID,
//                                                                     requestedUserID: self.userID!,
//                                                                     weekday: self.period!,
//                                                                     period: self.day!)
        
        if (selectedDriver!.requestedArray.contains(userID!)) {
            requestedButton.setTitle("Cancelar pedido", for: .normal)
            self.state = true
        }
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    // MARK: - Request for a ride
    @IBAction func resquestButton(_ sender: Any) {
        
        // Verifies if user already requested a ride or not
        
        if self.state == false {
            
            FirestoreManager.shared.sendRideRequest(driverID: self.selectedDriver!.userID,
                                                    requestedUserID: self.userID!,
                                                    weekday: self.period!,
                                                    period: self.day!)
            
            self.requestedButton.setTitle("Cancelar pedido", for: .normal)
            self.state = true
            
            let alert = UIAlertController(title: "Carona solicitada!", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            
            FirestoreManager.shared.removeRideRequest(driverID: self.selectedDriver!.userID,
                                                      requestedUserID: self.userID!,
                                                      weekday: self.period!,
                                                      period: self.day!)
            
            self.requestedButton.setTitle("Requisitar carona", for: .normal)
            self.state = false
            
            let alert = UIAlertController(title: "Carona cancelada!", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if isMovingFromParent{
            performSegue(withIdentifier: "backToMatch", sender: self)
        }
    }

}
