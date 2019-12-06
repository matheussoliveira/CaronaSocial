//
//  FirestoreManager.swift
//  CaronaSocial
//
//  Created by Matheus Oliveira on 14/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

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
    
    func sendResponsable(responsableName: String,
                         responsableCPF: String,
                         telephone: String,
                         email: String,
                         userID: String) {
        
        db.collection("users").document(userID).setData( [
            "name": responsableName,
            "cpf": responsableCPF,
            "telephone": telephone,
            "email": email,
        ]) { err in
            if let err = err {
                print("Error writing responsable: \(err)")
            } else {
                print("Responsable successfully written!")
            }
        }
    }
    
    func sendStudent(institution: String,
                     studentName: String,
                     studentCPF: String,
                     studentAge: String,
                     matriculation: String,
                     userID: String) {
        
        db.collection("users").document(userID).collection("student").document("information").setData([
            "name": studentName,
            "cpf": studentCPF,
            "age": studentAge,
            "institution": institution,
            "matriculation": matriculation]) { err in
                if let err = err {
                    print("Error writing student adress: \(err)")
                } else {
                    print("Student sucessefuly written!")
                }
        }
    }
    
    func sendEmployeeDriver(name: String,
                            cpf: String,
                            telephone: String,
                            email: String,
                            userID: String) {
        // Sends a employee object to Firestore.
        db.collection("users").document(userID).setData( [
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
    
    func sendLocation(userID: String, home: String, work: String, institution: String, homeCoord: CLLocationCoordinate2D, institutionCoord: CLLocationCoordinate2D, workCoord: CLLocationCoordinate2D) {
        // Sends all addresses and coordinates registered to Firestore.
        sendHomeLocation(home: home, coord: homeCoord, userID: userID)
        sendWorkLocation(work: work, coord: workCoord, userID: userID)
        sendInstitutionLocation(institution: institution, coord: institutionCoord, userID: userID)
    }
    
    func sendHomeLocation(home: String, coord: CLLocationCoordinate2D, userID: String) {
        // Send home adress and coodinates to Firestore.
        db.collection("users").document(userID).collection("locations").document("home").setData([
            "location": home,
            "latitude": "\(coord.latitude)",
            "longitude": "\(coord.longitude)"]) { err in
                if let err = err {
                    print("Error writing home adress: \(err)")
                } else {
                    print("Home sucessefuly written!")
                }
        }
    }
    
    func sendWorkLocation(work: String, coord: CLLocationCoordinate2D, userID: String) {
        // Sends work adress and coodinates to Firestore.
        db.collection("users").document(userID).collection("locations").document("work").setData([
            "location": work,
            "latitude": "\(coord.latitude)",
            "longitude": "\(coord.longitude)"]) { err in
                if let err = err {
                    print("Error writing work adress: \(err)")
                } else {
                    print("Work sucessefuly written!")
                }
        }
    }
    
    func sendInstitutionLocation(institution: String, coord: CLLocationCoordinate2D, userID: String) {
        // Sends institution adress and coodinates to Firestore.
        db.collection("users").document(userID).collection("locations").document("institution").setData([
            "location": institution,
            "latitude": "\(coord.latitude)",
            "longitude": "\(coord.longitude)"]) { err in
                if let err = err {
                    print("Error writing institution adress: \(err)")
                } else {
                    print("Institution sucessefuly written!")
                }
        }
    }
    
    func sendDriverUserID(userID: String) {
        // Send userID to drivers list
        db.collection("drivers").document(userID).setData([
            "userID": userID])
    }
    
    func sendPassengerUserID(userID: String) {
        // Send userID to passenger list
        db.collection("passengers").document(userID).setData([
            "userID": userID])
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
                        let object = RideModel(userID: document.get("user-id") as! String, time: document.get("time") as! String, origin: document.get("origin") as! String, destiny: document.get("destiny") as! String, originPoint: Point(latitude: document.get("originLat") as! String, longitude: document.get("originLong") as! String), destinyPoint: Point(latitude: document.get("destinyLat") as! String, longitude: document.get("destinyLong") as! String), vacant:"", accessibility: "", observation: "")
                        
                        self.ridesArray.append(object)
                        
                        print("Coord: \(object.originPoint)")
                    }
                    completion(self.ridesArray)
                }
            }
        }
        
    func fetchDailyRide(userID: String, weekDay: String, period: String, completion: @escaping (RideModel) -> Void){
//                let userId = "tNgfVIgCcUlI4fn1IAiw"
            db.collection("users").document(userID).collection("rides").document(weekDay).collection(period).document("infos").getDocument() { (document, err) in
                if let document = document, document.exists {
                    let ride = RideModel(userID: userID, time: document.get("time") as! String, origin: document.get("origin") as! String, destiny: document.get("destiny") as! String, originPoint: Point(latitude: document.get("originLatitude") as! String, longitude: document.get("originLongitude") as! String), destinyPoint: Point(latitude: document.get("destinyLatitude") as! String, longitude: document.get("destinyLongitude") as! String), vacant: "", accessibility: "", observation: "")
                    completion(ride)
                } else {
                    print("Document does not exist")
                }
            }
        }
    
    func getCoordinate(addressString : String, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
                
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    //returns if user is driver or passenger
    func checkUserType(userID: String, completion: @escaping (String) -> Void){
        
        db.collection("drivers").document(userID).getDocument() { (document, err) in
            if document!.exists{
                completion("driver")
            } else {
                completion("passenger")
            }
        }
    }
    
    //create default values for daily rides
    func createDefaultRides(userID: String, type: String, house: String, institution: String, houseCoord: CLLocationCoordinate2D, institutionCoord: CLLocationCoordinate2D){
        
        db.collection(type).document(userID).collection("rides").document("Manhã").setData([
            "origin": house,
            "originLat": "\(houseCoord.latitude)",
            "originLong": "\(houseCoord.longitude)",
            "destiny": institution,
            "destinyLat": "\(institutionCoord.latitude)",
            "destinyLong": "\(institutionCoord.longitude)",
            "time": "8h-9h"]){ err in
                if let err = err {
                    print("Error writing morning ride: \(err)")
                } else {
                    print("Morning ride sucessefuly written!")
                }
        }
        
        db.collection(type).document(userID).collection("rides").document("Tarde").setData([
            "origin": institution,
            "originLat": "\(institutionCoord.latitude)",
            "originLong": "\(institutionCoord.longitude)",
            "destiny": house,
            "destinyLat": "\(houseCoord.latitude)",
            "destinyLong": "\(houseCoord.longitude)",
            "time": "15h-16h"]){ err in
                if let err = err {
                    print("Error writing afternoon ride: \(err)")
                } else {
                    print("Afternoon ride sucessefuly written!")
                }
        }
        
        db.collection(type).document(userID).collection("rides").document("Noite").setData([
            "origin": institution,
            "originLat": "\(institutionCoord.latitude)",
            "originLong": "\(institutionCoord.longitude)",
            "destiny": house,
            "destinyLat": "\(houseCoord.latitude)",
            "destinyLong": "\(houseCoord.longitude)",
            "time": "19h-20h"]){ err in
                if let err = err {
                    print("Error writing night ride: \(err)")
                } else {
                    print("Night ride sucessefuly written!")
                }
        }
    }
    
    
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
