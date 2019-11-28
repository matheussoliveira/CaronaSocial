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
    let age: String
    let accessibility: Bool
    let profileImageURL: String
    let vacantPlaces: String
    let observation: String
    
    // Standard init
    init(name: String, cpf: String, age: String, accessibility: Bool,
         profileImageURL: String, vacantPlaces: String, observation: String) {
        self.name = name
        self.cpf = cpf
        self.age = age
        self.accessibility = accessibility
        self.profileImageURL = profileImageURL
        self.vacantPlaces = vacantPlaces
        self.observation = observation
    }
    
    // Init for reading from Database snapshot
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.name = snapshotValue["name"] as! String
        self.cpf = snapshotValue["cpf"] as! String
        self.age = snapshotValue["age"] as! String
        self.accessibility = snapshotValue["accessibility"] as! Bool
        self.profileImageURL = snapshotValue["profileImageURL"] as! String
        self.vacantPlaces = snapshotValue["vacantPlaces"] as! String
        self.observation = snapshotValue["observation"] as! String
    }
}
