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
    let memberName: String
    let birthdayDate: String
    let institution: String
    let registerNumber: String
    let profileImageURL: String

    // Standard init
    init(email: String, name: String, cpf: String, memberName: String, birthdayDate: String, institution: String, registerNumber: String, profileImageURL: String) {
        self.email = email
        self.name = name
        self.cpf = cpf
        self.memberName = memberName
        self.birthdayDate = birthdayDate
        self.institution = institution
        self.registerNumber = registerNumber
        self.profileImageURL = profileImageURL
    }

    // Init for reading from Database snapshot
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        email = snapshotValue["email"] as! String
        name = snapshotValue["name"] as! String
        cpf = snapshotValue["cpf"] as! String
        memberName = snapshotValue["memberName"] as! String
        birthdayDate = snapshotValue["birthdayDate"] as! String
        institution = snapshotValue["institution"] as! String
        registerNumber = snapshotValue["registerNumber"] as! String
        profileImageURL = snapshotValue["profileImageURL"] as! String
        
    }

    // Func converting model for easier writing to database
    func toAnyObject() -> Any {
        return [
            "email": email,
            "name": name,
            "cpf": cpf,
            "memberName": memberName,
            "birthdayDate": birthdayDate,
            "institution": institution,
            "registerNumber": registerNumber,
            "profileImageURL": profileImageURL
        ]
    }
}
