//
//  HomeViewController.swift
//  CaronaSocial
//
//  Created by Felipe Luna Tersi on 14/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class Home2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var day = ["Manhã", "Tarde", "Noite"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return day.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell

        cell.title.text = day[indexPath.row]
        
        return cell
        
    }

    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "matchScreen") as? MatchsTableViewController
        vc?.name = day[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
//        performSegue(withIdentifier: "rideDetail", sender: self)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "rideDetail" {
//            let cell = sender as! UITableViewCell
//            let index = homeTableView.indexPath(for: cell)
//            if let indexPath = index?.row {
//                selectDay = day[indexPath]
//            }
//        }
//    }
    
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        if identifier == "rideDetail" {
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
//            let newVC = storyBoard.instantiateViewController(identifier: "rideDetail") as! MatchsTableViewController
//            self.navigationController?.pushViewController(newVC, animated: true)
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
