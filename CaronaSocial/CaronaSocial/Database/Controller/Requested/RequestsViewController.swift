//
//  RequestsViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 04/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedSegment = 1
    
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
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.row == 0{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "requestTitle") as? RequestTitleTableViewCell
            
            if selectedSegment == 1{
                
                cell!.titleRequest.text = "Caronas pendentes"
                
                return cell!
                
                
            } else {
                
                cell!.titleRequest.text = "Caronas confirmadas"
                
                return cell!
                
            }
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "rideCell") as? RideTableViewCell
            
            if selectedSegment == 1 {
                
                cell?.places.text = "2 vagas"
                cell?.riderName.text = "Ana Claudia"
                cell?.distance.text = "Distância: 10km"
                cell?.wheelChair.text = "Não"
                return cell!
                
            } else {
                
//                cell?.places.text = "Teste1"
//                cell?.riderName.text = "Teste1"
//                cell?.distance.text = "Teste1"
                return cell!
                
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
//            vc?.driver = drivers?[indexPath.row-2]
//            vc?.newImage = driversImage![(indexPath.row-2)]
//            vc?.ride = self.dailyRide
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }

}
