//
//  FirestoreManager.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 14/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import Firebase
//import CoreLocation

class FirestoreManager{
    
    let db = Firestore.firestore()
    static let shared = FirestoreManager()
    var driversArray: [DriverModel] = []
    var ridesArray: [RideModel] = []


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
    
    func sendEmployeeDriver(name: String, cpf: String, telephone: String, email: String) {
        db.collection("users").document().setData( [
            "name": name,
            "cpf": cpf,
            "telephone": telephone,
            "email": email
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func sendLocation(userID: String, home: String, institution: String, work: String) {
        db.collection("users").document().collection("locations").addDocument(data: [
            "casa": home,
            "instituição": institution,
            "trabalho": work
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
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
                                             age: document.data()["age"] as! String,
                                             accessibility: document.data()["accessibility"] as! Bool,
                                             //location: document.data()["location"] as! String,
                                             profileImageURL: document.data()["profileImageURL"] as! String,
                                             vacantPlaces: document.data()["vacantPlaces"] as! String,
                                             observation: document.data()["observation"] as! String)
                    self.driversArray.append(driver)
                    let drivers = self.driversArray
                    completion(drivers)
                }
            }
        }
    }
    
    func fetchRides(type: String, completion: @escaping ([RideModel]) -> Void){
            let date = Date()
            let formatter = DateFormatter()
            
            ridesArray = []
            
            //get todays date and transform into database date model field
            formatter.dateFormat = "dd-MM-yyyy"
            let result = formatter.string(from: date)
            
            //fetch offering rides
            db.collection("rides").document("19-11-2019").collection(type).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("No rides registered today: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let object = RideModel(userID: document.get("user-id") as! String, time: document.get("time") as! String, origin: document.get("origin") as! String, destiny: document.get("destiny") as! String, originPoint: Point(latitude: document.get("originLat") as! String, longitude: document.get("originLong") as! String), destinyPoint: Point(latitude: document.get("destinyLat") as! String, longitude: document.get("destinyLong") as! String))
                        
                        self.ridesArray.append(object)
                        
                        print("Coord: \(object.originPoint)")
                    }
                    completion(self.ridesArray)
                }
            }
        }
        
        func fetchDailyRide(weekDay: String, period: String, completion: @escaping (RideModel) -> Void){
            var userId = "tNgfVIgCcUlI4fn1IAiw"
            print("")
            db.collection("users").document(userId).collection("rides").document("seg").collection(period).document("infos").getDocument() { (document, err) in
                if let document = document, document.exists {
                    var ride = RideModel(userID: userId, time: document.get("time") as! String, origin: document.get("origin") as! String, destiny: document.get("destiny") as! String, originPoint: Point(latitude: document.get("originLatitude") as! String, longitude: document.get("originLongitude") as! String), destinyPoint: Point(latitude: document.get("destinyLatitude") as! String, longitude: document.get("destinyLongitude") as! String))
                    completion(ride)
                } else {
                    print("Document does not exist")
                }
            }
        }
    
//    func getCoordinate( addressString : String, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
//        
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
//            if error == nil {
//                if let placemark = placemarks?[0] {
//                    let location = placemark.location!
//                        
//                    completionHandler(location.coordinate, nil)
//                    return
//                }
//            }
//                
//            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
//        }
//    }
    
//    func match() {
//
//        let group = DispatchGroup()
//
//        var driversLocation = "Av. Albert Einstein, 251, Cidade Universitária, Campinas - SP"
//        var passengerLocation = "Dr Mario de Nucci, 81, Cidade Universitária, Campinas - SP"
//
//        group.enter()
//        getCoordinate(addressString: driversLocation) { placemark, error in
//            if placemark != nil {
//                self.coordDriver = placemark
//                self.getCoordinate(addressString: passengerLocation) { placemark, error in
//                    if placemark != nil {
//                        self.coordPassenger = placemark
//                        group.leave()
//                    }
//                }
//            }
//        }
//
//        group.notify(queue: DispatchQueue.main) {
//            print("-------------------")
//            print("Driver \(self.coordDriver!)");
//            print("Passenger \(self.coordPassenger!)");
//
//            if self.coordPassenger?.latitude == self.coordDriver?.latitude && self.coordPassenger?.longitude == self.coordDriver?.longitude{
//                print("IT`S A MATCH")
//            } else {
//                print("IT`S NOT A MATCH")
//            }
//        }
//
//    }
    
    
}
