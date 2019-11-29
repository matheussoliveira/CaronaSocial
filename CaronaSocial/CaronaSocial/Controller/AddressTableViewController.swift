//
//  SelectAdressTableViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 25/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class AddressTableViewController: UITableViewController {

    @IBOutlet var adressTableView: UITableView!
    
    var name:[String] = []
    
    @IBAction func confirmButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name = ["Casa", "Trabalho", "Institutição"]

    // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func addAdress (adress: String) {
        name.append(adress)
    }
    
    @IBAction func backToAdress(_ segue: UIStoryboardSegue) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdressTableViewCell") as! AddressTableViewCell
        
        cell.adress.text = name[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "backToEditRote", sender: name[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToEditRote" {
            if let adressVC = segue.destination as? EditRoteTableViewController {
              adressVC.adress = sender as? String
            }
        }
        
        if segue.identifier == "newAdressSegue" {
            if let newAdressVC = segue.destination as? NewAddressTableViewController {
                newAdressVC.adressList = self
            }
        }
    }
}
