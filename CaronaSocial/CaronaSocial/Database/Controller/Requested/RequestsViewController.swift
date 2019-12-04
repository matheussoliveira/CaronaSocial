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
    
    @IBAction func indexChanged(_ sender: Any) {
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            cell?.places.text = "Teste"
            cell?.riderName.text = "Teste"
            return cell!
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

}
