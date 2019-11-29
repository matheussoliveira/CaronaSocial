//
//  NewAdressTableViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 25/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class NewAddressTableViewController: UITableViewController {

    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var neighborhood: UITextField!
    
    var adressList: AddressTableViewController?
    
    @IBAction func confirmButtom(_ sender: Any) {
        adressList?.addAdress(adress: street.text!)
        
        performSegue(withIdentifier: "backToAdress", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

}
