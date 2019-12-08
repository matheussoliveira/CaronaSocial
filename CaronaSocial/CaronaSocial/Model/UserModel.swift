//
//  User.swift
//  CaronaSocial
//
//  Created by Marina Miranda Aranha on 11/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct UserModel {
    
    let email: String
    let name: String
    let cpf: String
    let telephone: String
    let profileImageURL: String

    // Standard init
    init(email: String, name: String, cpf: String, telephone: String, profileImageURL: String) {
        self.email = email
        self.name = name
        self.cpf = cpf
        self.telephone = telephone
        self.profileImageURL = profileImageURL
    }


    // Func converting model for easier writing to database
    func toAnyObject() -> Any {
        return [
            "email": email,
            "name": name,
            "cpf": cpf,
            "telephone": telephone,
            "profileImageURL": profileImageURL
        ]
    }
}
