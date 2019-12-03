//
//  ResponsableDriver.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 03/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ReponsableDriver {
    // Defines a "resposável" who is also
    // a driver in app
    
    let type: String
    let studentName: String
    let studentCPF: String
    let studentAge: String
    let studentInstitution: String
    let matriculation: String
    let responsableName: String
    let responsableCPF: String
    let telephone: String
    let email: String
    let home: Location
    let institution: Location
    let work: Location
    
    // Standard init
    init(type: String, studentName: String, studentCPF: String,
         studentAge: String, studentInstitution: String, matriculation: String,
         responsableName: String, responsableCPF: String, telephone: String,
         email: String, home: Location, institution: Location, work: Location) {
        
        self.type = type
        self.studentName = studentName
        self.studentCPF = studentCPF
        self.studentAge = studentAge
        self.studentInstitution = studentInstitution
        self.matriculation = matriculation
        self.responsableName = responsableName
        self.responsableCPF = responsableCPF
        self.telephone = telephone
        self.email = email
        self.home = home
        self.institution = institution
        self.work = work
        
    }
    
    // Init for reading from Database snapshot
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.type = snapshotValue["type"] as! String
        self.studentName = snapshotValue["studentName"] as! String
        self.studentCPF = snapshotValue["studentCPF"] as! String
        self.studentAge = snapshotValue["studentAge"] as! String
        self.studentInstitution = snapshotValue["studentInstitution"] as! String
        self.matriculation = snapshotValue["matriculation"] as! String
        self.responsableName = snapshotValue["responsableName"] as! String
        self.responsableCPF = snapshotValue["responsableCPF"] as! String
        self.telephone = snapshotValue["telephone"] as! String
        self.email = snapshotValue["email"] as! String
        // Fix locations
        self.home = snapshotValue["home"] as! Location
        self.institution = snapshotValue["institution"] as! Location
        self.work = snapshotValue["work"] as! Location
    }
    
}
