//
//  TabBarController.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 09/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true 
        navigationController?.navigationBar.prefersLargeTitles = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
