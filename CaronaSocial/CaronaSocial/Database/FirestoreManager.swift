//
//  FirestoreManager.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 14/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import Firebase

class FirestoreManager {
    
    let db = Firestore.firestore()
    static let shared = FirestoreManager()
    var driversArray: [DriverModel] = []

    func observeUsers() {
        // Let us obeserve users propresties from
        // Firestore database
        db.collection("driver").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data()["name"])")
                }
            }
        }
    }
    
    func buildDrivers(completion: @escaping ([DriverModel]) -> Void) {
        // Take all drivers from our Firestore databse and
        // transform it into a DriverModel object
        self.driversArray = []
        db.collection("driver").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let driver = DriverModel(name: document.data()["name"] as! String,
                                             cpf: document.data()["cpf"] as! String,
                                             age: document.data()["age"] as! Int,
                                             accessibility: document.data()["accessibility"] as! Bool,
                                             location: document.data()["location"] as! String,
                                             profileImageURL: document.data()["profileImageURL"] as! String)
                    self.driversArray.append(driver)
                    let drivers = self.driversArray
                    completion(drivers)
                }
            }
        }
    }
    
    
}
