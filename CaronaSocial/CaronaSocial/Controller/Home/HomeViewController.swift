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
    let imageArray = [UIImage(named: "morning"), UIImage(named: "evening"), UIImage(named: "moon")]
    var rideTarde: RideModel?
    var rideManha: RideModel?
    var rideNoite: RideModel?
    var rows: Int?
    var activityIndicatorView: UIActivityIndicatorView!
    let dispatchQueue = DispatchQueue(label: "Queue")
    var period: RideModel?
    var buttonManager = ButtonManager()
    var weekDay: String?

    @IBOutlet var dayButtons: [UIButton]!
    
    @IBOutlet weak var homeTableView: UITableView!
    
    //view for activity indicator
    override func loadView() {
        super.loadView()
    
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
        homeTableView.backgroundView = activityIndicatorView
    }
    
    @IBAction func dayButtonsPressed(_ sender: UIButton) {
        let group = DispatchGroup()
        sender.isSelected = !sender.isSelected
        var weekDay: String = ""
        var numNotSelectedButtons: Int = 0
        
        switch sender.tag {
        case 1:
            weekDay = "seg"
        case 2:
            weekDay = "ter"
        case 3:
            weekDay = "qua"
        case 4:
            weekDay = "qui"
        case 5:
            weekDay = "sex"
        default:
            print("ERROR")
        }
        
        self.weekDay = weekDay
        
        activityIndicatorView.startAnimating()
        homeTableView.separatorStyle = .none
        
        dispatchQueue.async {
            OperationQueue.main.addOperation() {
                group.enter()
                FirestoreManager.shared.fetchDailyRide(weekDay: self.weekDay!, period: "Manhã"){ result in
                    self.rideManha = result
                    group.leave()
                }
                
                group.enter()
                FirestoreManager.shared.fetchDailyRide(weekDay: self.weekDay!, period: "Tarde"){ result in
                    self.rideTarde = result
                    group.leave()
                }
                
                group.enter()
                FirestoreManager.shared.fetchDailyRide(weekDay: self.weekDay!, period: "Noite"){ result in
                    self.rideNoite = result
                    group.leave()
                }
        
        
        
                for button in self.dayButtons {

                    
                    // Handle single button selection
                    if button.tag != sender.tag && button.isSelected && sender.isSelected {
                        self.buttonManager.notSelectedButtonDesign(button: button)
                    }
                }
                
                // Set pressed button design
                if sender.isSelected {
                    self.buttonManager.selectedButtonDesign(button: sender)
                } else {
                    self.buttonManager.notSelectedButtonDesign(button: sender)
                }
                
                group.notify(queue: .main) {
                    self.activityIndicatorView.stopAnimating()
                    self.homeTableView.reloadData()
                }
            }
        }
        
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Meu id é: \(FirebaseManager.shared.getUserID())")
        
        // Day buttons not selected
        for button in dayButtons {
            button.isSelected = false
        }
        dayButtons[0].isSelected = true
        buttonManager.selectedButtonDesign(button: dayButtons[0])
        self.weekDay = "seg"
        
        
        // Button corner radius
        for button in dayButtons {
            button.layer.cornerRadius = 6
        }
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
                    FirestoreManager.shared.fetchDailyRide(weekDay: self.weekDay!, period: "Manhã"){ result in
                        self.rideManha = result
                        group.leave()
                    }
                    
                    group.enter()
                    FirestoreManager.shared.fetchDailyRide(weekDay: self.weekDay!, period: "Tarde"){ result in
                        self.rideTarde = result
                        group.leave()
                    }
                    
                    group.enter()
                    FirestoreManager.shared.fetchDailyRide(weekDay: self.weekDay!, period: "Noite"){ result in
                        self.rideNoite = result
                        group.leave()
                    }
                    
                    group.notify(queue: .main) {
                        self.rows = 1
                        self.activityIndicatorView.stopAnimating()
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
        cell.imageDay.image = imageArray[indexPath.row]
        
        if rows != nil{
            if day[indexPath.row] == "Manhã"{
                period = self.rideManha!
            } else if day[indexPath.row] == "Tarde"{
                period = self.rideTarde!
            } else if day[indexPath.row] == "Noite"{
                period = self.rideNoite!
            }
            
//            let delimiter = ","
//            let addressD = period!.destiny.components(separatedBy: delimiter)
//            let addressO = period!.origin.components(separatedBy: delimiter)
//            cell.rote.text = addressO[0] + "," + addressO[1] + "-" + addressD[0] + "," + addressD[1]
            
            cell.rote.text = period!.origin + " - " + period!.destiny
            cell.schudle.text = period!.time

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
