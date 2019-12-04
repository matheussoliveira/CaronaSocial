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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if selectedSegment == 1,
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "requestTitle") as? RequestTitleTableViewCell {
            
            cell1.titleRequest.text = "Caronas confirmadas"
            
            return cell1
            
            
        } else if selectedSegment == 2,
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "requestTitle") as? RequestTitleTableViewCell {
            
            cell1.titleRequest.text = "Caronas pendentes"
            
            return cell1
            
        }
        
         return UITableViewCell()
        
    }

}
