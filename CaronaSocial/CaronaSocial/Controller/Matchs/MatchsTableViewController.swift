//
//  MatchsTableViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 18/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

struct Rote {
    var start: String
    var destiny: String
    var departure: String
    var arrival: String
}

class MatchsTableViewController: UITableViewController {
    
    var roteCard:[Rote] = []
        
    func addRote(rote: Rote)  {
        roteCard.append(rote)
    }
    
    var name = ""
    var drivers: [DriverModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        // Retrieving information from firestore and building
        // drivers as objects
        FirestoreManager.shared.buildDrivers { (drivers) in
            self.drivers = drivers
            OperationQueue.main.addOperation {
               self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.drivers?.count ?? 0) + 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roteCell") as! RoteTableViewCell
            
            if roteCard.count != 0 {
                let rote = roteCard[indexPath.row]
                
                cell.start.text = rote.start
                cell.destiny.text = rote.destiny
                cell.departureTime.text = rote.departure
                cell.arrivalTime.text = rote.arrival
            }
            cell.period.text = name
            
            return cell
            
        } else if indexPath.row == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! TitleTableViewCellMatch
            cell.rideNumber.text = "Numero de pessoas oferecendo carona: \(drivers?.count ?? 0)"
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! MatchTableViewCell
            if let driver = drivers?[(indexPath.row-2)] {
                FirebaseManager.downloadImage(withURL:
                URL(string: driver.profileImageURL)!) {
                    image in cell.driverImage.image = image
                    cell.driver.text = driver.name
                    cell.vacantPlaces.text = "2"
                    cell.distance.text = "Distância: 10km"
                }
            }
            
            return cell
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editRote" {
            if let editRoteVC  = segue.destination as? EditRoteTableViewController {
                editRoteVC.rote = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Condition for specific height
        if indexPath.row == 0 {
            return 175
        } else if indexPath.row == 1 {
            return 54
        } else {
            return 140
        }
    }
    
    @IBAction func backToMatch(_ segue: UIStoryboardSegue) {
        
    }
    
}
