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
    var drivers: [UserModel]?
//    var driver: DriverModel?
    var dailyRide: RideModel?
    var driversImage: [UIImage]?
    var profileImage: UIImage?
    var userType: String?
    var day: String?
    var period: String?
    var matchRides: [RideModel] = []

    
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
        
        var rides: [RideModel] = []

        if (rows == nil) {
            activityIndicatorView.startAnimating()

            tableView.separatorStyle = .none

            dispatchQueue.async {


                OperationQueue.main.addOperation() {
                    var fetchType: String?
                    
                    if self.userType == "drivers"{
                        fetchType = "passengers"
                    } else {
                        fetchType = "drivers"
                    }
                    
                    //get rides, perfom match and build match drivers
                    group.enter()
                    FirestoreManager.shared.fetchRides(type: fetchType!, day: self.day!, period: self.period!){ result in
                        rides = result
                        group.enter()
                        self.match(rides: rides){ result in
                            self.drivers = result
                            group.enter()
                            FirebaseManager.downloadImages(drivers: self.drivers!) { images in
                                self.driversImage = images
                                group.leave()
                            }
                            group.leave()
                        }
                        group.leave()
                    }
                    
                    
                    
                    //fetch todas as rides de tipo oposto
                    //comparar com endereço de destino, origem e horário
        
//                    group.enter()
//                    FirestoreManager.shared.buildDrivers { (drivers) in
//                        self.drivers = drivers
//
//                        group.enter()
//                        FirebaseManager.downloadImages(drivers: self.drivers!) { images in
//                            self.driversImage = images
//                            group.leave()
//                        }
//
//                        group.leave()
//                    }
//                    self.drivers = []
                    
                    group.notify(queue: .main) {
                        self.rows = ["One", "Two"]

                        self.activityIndicatorView.stopAnimating()

                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
    }
    
    func match(rides: [RideModel], completion: @escaping ([UserModel]) -> Void){
        let group = DispatchGroup()
        var matchDrivers: [UserModel] = []
        
        //search for match rides
        for ride in rides{
            if (ride.destinyPoint.latitude == self.dailyRide?.destinyPoint.latitude &&
                ride.destinyPoint.longitude == self.dailyRide?.destinyPoint.longitude &&
                ride.originPoint.latitude == self.dailyRide?.originPoint.latitude &&
                ride.originPoint.longitude == self.dailyRide?.originPoint.longitude){
                if ride.time == self.dailyRide?.time{
                    self.matchRides.append(ride)
                }
            }
        }
        
        //get match drivers
        for matchRide in self.matchRides{
            group.enter()
            FirestoreManager.shared.fetchDriver(userID: matchRide.userID){ result in
                matchDrivers.append(result)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(matchDrivers)
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
//            var address = self.dailyRide!.destiny.components(separatedBy: delimiter)
            
//            cell.destiny.text = address[0] + "," + address[1]
//            address = self.dailyRide!.origin.components(separatedBy: delimiter)
//            cell.start.text = address[0] + "," + address[1]
            cell.destiny.text = self.dailyRide?.destinyType
            cell.start.text = self.dailyRide?.originType
            cell.departureTime.text = self.dailyRide?.time
            
            return cell
        } else if indexPath.row == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! TitleTableViewCellMatch
            if self.userType == "drivers"{
                cell.rideNumber.text = "Pessoas requisitando carona: \(drivers?.count ?? 0)"
            } else {
                cell.rideNumber.text = "Pessoas oferecendo carona: \(drivers?.count ?? 0)"
            }
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
            return 216
        } else if indexPath.row == 1 {
            return 54
        } else {
            return 140
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 2) {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "driverScreen") as? DriverMatchTableViewController
            
            vc?.driver = drivers?[indexPath.row-2]
            vc?.newImage = driversImage![(indexPath.row-2)]
            vc?.ride = self.dailyRide

            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}
