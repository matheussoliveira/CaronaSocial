//
//  RequestsViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 04/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit
import Firebase

class RequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedSegment = 1
    var userID: String?
    var rows: [String]?
    var activityIndicatorView: UIActivityIndicatorView!
    let dispatchQueue = DispatchQueue(label: "Queue")
    var driversRequested: [UserModel]?
    var ridesRequested: [RideModel]?
    var rides: [RideModel] = []
    var drivers: [UserModel] = []
    var images: [UIImage]?
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func switchSegmented(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            selectedSegment = 1
            
        } else {
            
            selectedSegment = 2
        
        }
        
        self.tableView.reloadData()
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        navigationController?.navigationBar.barTintColor = UIColor.customBlue
        
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let group = DispatchGroup()
        self.images = []

        var type: String?

        self.userID = FirebaseManager.shared.getUserID()
                
        if (rows == nil) {
//            activityIndicatorView.startAnimating()

            tableView.separatorStyle = .none

            dispatchQueue.async {


                OperationQueue.main.addOperation() {

                    group.enter()
                    FirestoreManager.shared.checkUserType(userID: self.userID!){ result in
                        type = result
                        
                        group.enter()
                        FirestoreManager.shared.fetchRequestsRides(userID: self.userID!, type: type!){ result in
                            self.rides = result
                        
                            for ride in self.rides{
                                group.enter()
                                FirestoreManager.shared.fetchDriver(userID: ride.userID){ result in
                                    self.drivers.append(result)
                                    group.leave()
                                }
                            }
                            
                            group.leave()
                        }
                        
                        group.leave()
                    }

                            
                    group.notify(queue: .main) {
                        self.rows = ["One", "Two"]
                        
                        for user in self.drivers {
                            group.enter()
                            FirebaseManager.shared.downloadImage(withURL: URL(string: user.profileImageURL)!){ result in
                                self.images?.append(result!)
                                group.leave()
                            }
                        }
                        group.notify(queue: .main) {
                            self.tableView.reloadData()
                        }

                    }
    
                }
            
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (rows == nil) ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.driversRequested?.count ?? 0) + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.row == 0{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "requestTitle") as? RequestTitleTableViewCell
            
            if selectedSegment == 1{
                if self.rides.count > 0{
                    cell!.titleRequest.text = "Caronas pendentes"
                }else{
                    cell!.titleRequest.text = "Não há caronas pendentes"
                }
                
                return cell!
                
                
            } else {
                if self.rides.count > 0{
                    cell!.titleRequest.text = "Caronas confirmadas"
                }else {
                    cell!.titleRequest.text = "Não há caronas confirmadas"
                }
                return cell!
                
            }
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "rideCell") as? RideTableViewCell
            
            if selectedSegment == 1 {
                if self.rides.count > 0{
                    cell?.places.text = self.rides[indexPath.row-1].vacant
                    cell?.riderName.text = self.drivers[indexPath.row-1].name
                    cell?.distance.text = self.rides[indexPath.row-1].time
                    cell?.profileImage.image = self.images![indexPath.row-1]
                    cell?.wheelChair.text = "Sim"
                    
                    cell?.places.text = "1 vaga"
                }
                return cell!
            } else {
                
//                cell?.places.text = "Teste1"
//                cell?.riderName.text = "Teste1"
//                cell?.distance.text = "Teste1"
                return cell!
                
            }
        }
   }
    
    override func viewDidAppear(_ animated: Bool) {
        let group = DispatchGroup()
                self.images = []

                var type: String?

                self.userID = FirebaseManager.shared.getUserID()
                        
                if (rows == nil) {
        //            activityIndicatorView.startAnimating()

                    tableView.separatorStyle = .none

                    dispatchQueue.async {


                        OperationQueue.main.addOperation() {

                            group.enter()
                            FirestoreManager.shared.checkUserType(userID: self.userID!){ result in
                                type = result
                                
                                group.enter()
                                FirestoreManager.shared.fetchRequestsRides(userID: self.userID!, type: type!){ result in
                                    self.rides = result
                                
                                    for ride in self.rides{
                                        group.enter()
                                        FirestoreManager.shared.fetchDriver(userID: ride.userID){ result in
                                            self.drivers.append(result)
                                            group.leave()
                                        }
                                    }
                                    
                                    group.leave()
                                }
                                
                                group.leave()
                            }

                                    
                            group.notify(queue: .main) {
                                self.rows = ["One", "Two"]
                                
                                for user in self.drivers {
                                    group.enter()
                                    FirebaseManager.shared.downloadImage(withURL: URL(string: user.profileImageURL)!){ result in
                                        self.images?.append(result!)
                                        group.leave()
                                    }
                                }
                                group.notify(queue: .main) {
                                    self.tableView.reloadData()
                                }

                            }
            
                        }
                    
                    }
                }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Condition for specific height
        if indexPath.row == 0 {
            return 54
        } else {
            return 140
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 1) {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "driverRequested") as? DriverRequestedTableViewController
            vc?.driver = self.drivers[indexPath.row-1]
            vc?.ride = self.rides[indexPath.row-1]
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }

}
