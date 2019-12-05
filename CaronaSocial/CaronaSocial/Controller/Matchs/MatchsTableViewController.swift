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

class MatchsTableViewController: UITableViewController {
    
    var activityIndicatorView: UIActivityIndicatorView!
    var rows: [String]?
    let dispatchQueue = DispatchQueue(label: "Queue")
    var name = ""
    var drivers: [DriverModel]?
    var driver: DriverModel?
    var dailyRide: RideModel?
    var driversImage: [UIImage]?
    var profileImage: UIImage?
    
    override func loadView() {
        super.loadView()
    
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
        tableView.backgroundView = activityIndicatorView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let group = DispatchGroup()


        if (rows == nil) {
            activityIndicatorView.startAnimating()

            tableView.separatorStyle = .none

            dispatchQueue.async {


                OperationQueue.main.addOperation() {
                    
//                    group.enter()
                    //checar se o usuario esta oferencendo ou requisitando
                    //fetch todas as rides de tipo oposto
                    //comparar com endereço de destino, origem e horário
        
                    group.enter()
                    FirestoreManager.shared.buildDrivers { (drivers) in
                        self.drivers = drivers
                        
                        group.enter()
                        FirebaseManager.downloadImages(drivers: self.drivers!) { images in
                            self.driversImage = images
                            group.leave()
                        }
                        
                        group.leave()
                    }
                    
                    group.notify(queue: .main) {
                        self.rows = ["One", "Two"]

                        self.activityIndicatorView.stopAnimating()

                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (rows == nil) ? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.drivers?.count ?? 0) + 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roteCell") as! RoteTableViewCell
            cell.period.text = name
            
                
            //split address
            let delimiter = ","
            var address = self.dailyRide!.destiny.components(separatedBy: delimiter)
            
//            cell.destiny.text = address[0] + "," + address[1]
//            address = self.dailyRide!.origin.components(separatedBy: delimiter)
//            cell.start.text = address[0] + "," + address[1]
            cell.destiny.text = self.dailyRide?.destiny
            cell.start.text = self.dailyRide?.origin
            cell.departureTime.text = self.dailyRide?.time
            
            return cell
        } else if indexPath.row == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! TitleTableViewCellMatch
            cell.rideNumber.text = "Pessoas oferecendo carona: \(drivers?.count ?? 0)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! MatchTableViewCell
            if let driver = drivers?[(indexPath.row-2)] {
                cell.driverImage.image = driversImage![(indexPath.row-2)]
                cell.driver.text = driver.name
                cell.vacantPlaces.text = "2"
                cell.distance.text = "Distância: 10km"
            }
            
            return cell
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 2) {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "driverScreen") as? DriverViewController
            vc?.driver = drivers?[indexPath.row-2]
            vc?.newImage = driversImage![(indexPath.row-2)]
            vc?.ride = self.dailyRide

            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}
