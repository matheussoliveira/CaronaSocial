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
    var loaded: Int?


    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let group = DispatchGroup()
        super.viewWillAppear(animated)
        self.loaded = 0
        
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
            self.loaded = 1
            self.homeTableView.reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return day.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var period: RideModel?
        
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        cell.title.text = day[indexPath.row]
        
        if loaded != 0{
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
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
