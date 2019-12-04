//
//  EmployeeDriverModel.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 03/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import FirebaseDatabase

class EmplyeeDriverModel {
    // Defines a employee who is also
    // a driver in app
    
    let type: String
    let name: String
    let cpf: String
    let telephone: String
    let email: String
    let password: String
    
    // Standard init
    init(type: String, name: String, cpf: String,
         telephone: String, email: String, password: String) {
        
        self.type = type
        self.name = name
        self.cpf = cpf
        self.telephone = telephone
        self.email = email
        self.password = password
    }
    
    // Init for reading from Database snapshot
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.type = snapshotValue["type"] as! String
        self.name = snapshotValue["name"] as! String
        self.cpf = snapshotValue["cpf"] as! String
        self.telephone = snapshotValue["telephone"] as! String
        self.email = snapshotValue["email"] as! String
        self.password = "unkown"
    }
}
