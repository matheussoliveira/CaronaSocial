//
//  RegisterViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 07/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class RegisterTableViewController: UITableViewController {
    
    @IBOutlet var registerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let footerView = UIView()
        registerTableView.tableFooterView = footerView
    }
    
}
