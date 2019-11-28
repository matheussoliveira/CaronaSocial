//
//  TestViewController.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 21/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func teste(_ sender: Any) {
        FirebaseManager.uploadProfileImage(imageView: self.logo)
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
