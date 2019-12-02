//
//  HomeViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 14/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var day = ["Manhã", "Tarde", "Noite"]
    var rideTarde: RideModel?
    var rideManha: RideModel?
    var rideNoite: RideModel?
    var rows: Int?
    var activityIndicatorView: UIActivityIndicatorView!
    let dispatchQueue = DispatchQueue(label: "Queue")
    var period: RideModel?


    @IBOutlet weak var homeTableView: UITableView!
    
    //view for activity indicator
    override func loadView() {
        super.loadView()
    
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
        homeTableView.backgroundView = activityIndicatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let group = DispatchGroup()
        super.viewWillAppear(animated)
        
        //fetch daily rides to populate cards
        if self.rows == nil{
            activityIndicatorView.startAnimating()
            homeTableView.separatorStyle = .none
            
            dispatchQueue.async {
                OperationQueue.main.addOperation() {
                    group.enter()
                    FirestoreManager.shared.fetchDailyRide(weekDay: "seg", period: "Manhã"){ result in
                        self.rideManha = result
                        group.leave()
                    }
                    
                    group.enter()
                    FirestoreManager.shared.fetchDailyRide(weekDay: "seg", period: "Tarde"){ result in
                        self.rideTarde = result
                        group.leave()
                    }
                    
                    group.enter()
                    FirestoreManager.shared.fetchDailyRide(weekDay: "seg", period: "Noite"){ result in
                        self.rideNoite = result
                        group.leave()
                    }
                    
                    group.notify(queue: .main) {
                        self.rows = 1
                        self.activityIndicatorView.stopAnimating()
                        self.homeTableView.separatorStyle = .singleLine
                        self.homeTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (rows == nil) ? 0 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return day.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        cell.title.text = day[indexPath.row]
        
        if rows != nil{
            if day[indexPath.row] == "Manhã"{
                period = self.rideManha!
            } else if day[indexPath.row] == "Tarde"{
                period = self.rideTarde!
            } else if day[indexPath.row] == "Noite"{
                period = self.rideNoite!
            }
            
            let delimiter = ","
            let addressD = period!.destiny.components(separatedBy: delimiter)
            let addressO = period!.origin.components(separatedBy: delimiter)
            
            cell.schudle.text = period!.time
            cell.rote.text = addressO[0] + "," + addressO[1] + "-" + addressD[0] + "," + addressD[1]
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "matchScreen") as? MatchsTableViewController
        vc?.name = day[indexPath.row]
        
        if day[indexPath.row] == "Manhã"{
            period = self.rideManha!
        } else if day[indexPath.row] == "Tarde"{
            period = self.rideTarde!
        } else if day[indexPath.row] == "Noite"{
            period = self.rideNoite!
        }
        
        vc?.dailyRide = period
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
