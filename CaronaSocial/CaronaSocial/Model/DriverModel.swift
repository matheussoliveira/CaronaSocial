//
//  DriverModel.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 14/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import Firebase

class DriverModel {
    
    let name: String
    let cpf: String
    let age: Int
    let accessibility: Bool
    let location: String
    let profileImageURL: String
    
    // Standard init
    init(name: String, cpf: String, age: Int, accessibility: Bool, location: String, profileImageURL: String) {
        self.name = name
        self.cpf = cpf
        self.age = age
        self.accessibility = accessibility
        self.location = location
        self.profileImageURL = profileImageURL
    }
    
    // Init for reading from Database snapshot
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.name = snapshotValue["name"] as! String
        self.cpf = snapshotValue["cpf"] as! String
        self.age = snapshotValue["age"] as! Int
        self.accessibility = snapshotValue["accessibility"] as! Bool
        self.location = snapshotValue["location"] as! String
        self.profileImageURL = snapshotValue["profileImageURL"] as! String
    }
}
