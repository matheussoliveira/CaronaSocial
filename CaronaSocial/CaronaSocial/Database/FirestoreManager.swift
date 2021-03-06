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
    var requestedArray: [String] = []
    var requests: [RequestModel] = []


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
    
    func addListener(userID: String) {
        // Let us know if there was any change on selected
        // user document in Firestore
        
        db.collection("users").document(userID)
        .addSnapshotListener { documentSnapshot, error in
          guard let document = documentSnapshot else {
            print("Error fetching document: \(error!)")
            return
          }
          guard let data = document.data() else {
            print("Document data was empty.")
            return
          }
          print("Current data: \(data)")
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
            "profileImageURL": "https://firebasestorage.googleapis.com/v0/b/caronasocial-4ffa6.appspot.com/o/Images%2FLipinho.jpg?alt=media&token=5f6e41fc-264d-4a8e-8202-6067772b6d12"
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
            "email": email,
            "profileImageURL": "https://firebasestorage.googleapis.com/v0/b/caronasocial-4ffa6.appspot.com/o/Images%2FLipinho.jpg?alt=media&token=5f6e41fc-264d-4a8e-8202-6067772b6d12"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func sendNewAddress(userID: String, address: String, coordinates: CLLocationCoordinate2D) {
        // Send new adress and coordinates to Firestore.
        db.collection("users").document(userID).collection("locations").document(address).setData([
            "location": address,
            "latitude": "\(coordinates.latitude)",
            "longitude": "\(coordinates.longitude)"]) { err in
                if let err = err {
                    print("Error writing new adress: \(err)")
                } else {
                    print("New address sucessefuly written!")
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
    
    //get driver given an ID
    func fetchDriver(userID: String, completion: @escaping (UserModel) -> Void) {
        
        db.collection("users").document(userID).getDocument() { (document, err) in
            if let err = err {
                print("Error getting user document: \(err)")
            } else {
                let driver = UserModel(email: document?.data()?["email"] as! String,
                                       name: document?.data()?["name"] as! String,
                                       cpf: document?.data()?["cpf"] as! String,
                                       telephone: document?.data()?["telephone"] as! String,
                                       profileImageURL: document?.data()?["profileImageURL"] as! String)
                    
                completion(driver)
            }
        }
    }

        
    func fetchDailyRide(type: String, userID: String, weekDay: String, period: String, completion: @escaping (RideModel) -> Void){

            db.collection(type).document(userID).collection("rides").document(weekDay).collection(period).document("infos").getDocument() { (document, err) in
                if let document = document, document.exists {
                    
                    let ride = RideModel(userID: userID, time: document.get("time") as! String, origin: document.get("origin") as! String, destiny: document.get("destiny") as! String, originPoint: Point(latitude: document.get("originLat") as! String, longitude: document.get("originLong") as! String), destinyPoint: Point(latitude: document.get("destinyLat") as! String, longitude: document.get("destinyLong") as! String), vacant: "", accessibility: "", observation: "", originType: document.get("originType") as! String, destinyType: document.get("destinyType") as! String, requestedArray: document.get("requested") as! [String])
                    completion(ride)
                } else {
                    print("Document does not exist")
                }
            }
        }
    
    //transform address into coordinates
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
                completion("drivers")
            } else {
                completion("passengers")
            }
        }
    }
    
    //create default values for daily rides
    func createDefaultRides(userID: String, type: String, house: String, institution: String, houseCoord: CLLocationCoordinate2D, institutionCoord: CLLocationCoordinate2D){
        
        let weekDays = ["Seg", "Ter", "Qua", "Qui", "Sex"]
        
        for weekDay in weekDays{
            
            var path = db.collection(type).document(userID).collection("rides").document(weekDay)
            createDefaultRideDay(path: path, userID: userID, type: type, house: house, institution: institution, houseCoord: houseCoord, institutionCoord: institutionCoord)
            
        }

    }
    
    //create default values for daily rides
    func createDefaultRideDay(path: DocumentReference, userID: String, type: String, house: String, institution: String, houseCoord: CLLocationCoordinate2D, institutionCoord: CLLocationCoordinate2D){
        
        
        
        path.collection("Manhã").document("infos").setData([
            "originType": "Casa",
            "destinyType": "Instituição",
            "origin": house,
            "originLat": "\(houseCoord.latitude)",
            "originLong": "\(houseCoord.longitude)",
            "destiny": institution,
            "destinyLat": "\(institutionCoord.latitude)",
            "destinyLong": "\(institutionCoord.longitude)",
            "time": "08h00-09h00",
            "accessibility": "Não",
            "vacant": "1",
            "observation": "",
            "requested": [""]]){ err in
                if let err = err {
                    print("Error writing morning ride: \(err)")
                } else {
                    print("Morning ride sucessefuly written!")
                }
        }
        
        path.collection("Tarde").document("infos").setData([
            "originType": "Instituição",
            "destinyType": "Casa",
            "origin": institution,
            "originLat": "\(institutionCoord.latitude)",
            "originLong": "\(institutionCoord.longitude)",
            "destiny": house,
            "destinyLat": "\(houseCoord.latitude)",
            "destinyLong": "\(houseCoord.longitude)",
            "time": "15h00-16h00",
            "accessibility": "Não",
            "vacant": "1",
            "observation": "",
            "requested": [""]
            ]){ err in
                if let err = err {
                    print("Error writing afternoon ride: \(err)")
                } else {
                    print("Afternoon ride sucessefuly written!")
                }
        }
        
        path.collection("Noite").document("infos").setData([
            "originType": "Instituição",
            "destinyType": "Casa",
            "origin": institution,
            "originLat": "\(institutionCoord.latitude)",
            "originLong": "\(institutionCoord.longitude)",
            "destiny": house,
            "destinyLat": "\(houseCoord.latitude)",
            "destinyLong": "\(houseCoord.longitude)",
            "time": "19h00-20h00",
            "accessibility": "Não",
            "vacant": "1",
            "observation": "",
            "requested": [""]]){ err in
                if let err = err {
                    print("Error writing night ride: \(err)")
                } else {
                    print("Night ride sucessefuly written!")
                }
        }
    }
    
    func setDailyRide(userID: String, userType:String, period: String, day: String, newRide: RideModel, completionHandler: @escaping(String) -> Void){
        db.collection(userType).document(userID).collection("rides").document(day).collection(period).document("infos").setData([
            "originType": newRide.originType,
            "destinyType": newRide.destinyType,
            "origin": newRide.origin,
            "originLat": "\(newRide.originPoint.latitude)",
            "originLong": "\(newRide.originPoint.longitude)",
            "destiny": newRide.destiny,
            "destinyLat": "\(newRide.destinyPoint.latitude)",
            "destinyLong": "\(newRide.destinyPoint.longitude)",
            "time": newRide.time,
            "accessibility": newRide.accessibility,
            "vacant": newRide.vacant,
            "observation": newRide.observation,
            "requested": [""]
            ]){ err in
                if let err = err {
                    print("Error writing afternoon ride: \(err)")
                    completionHandler("Error")
                } else {
                    print("Afternoon ride sucessefuly written!")
                    completionHandler("Success")
                }
        }
    }
    
    func fetchRides(type : String, day: String, period: String, completionHandler: @escaping([RideModel]) -> Void){
        let group = DispatchGroup()
        var rides: [RideModel] = []
        db.collection(type).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("No rides registered today: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    group.enter()
                    var ride: RideModel?
                    self.db.collection(type).document(doc.documentID).collection("rides").document(day).collection(period).document("infos").getDocument(){
                        (document, err) in
                        if let err = err{
                            print("No rides registered today: \(err)")
                        } else{
                            if let document = document, document.exists {
                                if document.get("requested") == nil{
                                                                     ride = RideModel(userID: doc.documentID, time: document.get("time") as! String, origin: document.get("origin") as! String, destiny: document.get("destiny") as! String, originPoint: Point(latitude: document.get("originLat") as! String, longitude: document.get("originLong") as! String), destinyPoint: Point(latitude: document.get("destinyLat") as! String, longitude: document.get("destinyLong") as! String), vacant: "", accessibility: "", observation: "", originType: document.get("originType") as! String, destinyType: document.get("destinyType") as! String, requestedArray: [])
                                    
                                } else{
                                     ride = RideModel(userID: doc.documentID, time: document.get("time") as! String, origin: document.get("origin") as! String, destiny: document.get("destiny") as! String, originPoint: Point(latitude: document.get("originLat") as! String, longitude: document.get("originLong") as! String), destinyPoint: Point(latitude: document.get("destinyLat") as! String, longitude: document.get("destinyLong") as! String), vacant: "", accessibility: "", observation: "", originType: document.get("originType") as! String, destinyType: document.get("destinyType") as! String, requestedArray: document.get("requested") as! [String])
                                }
                                
                                rides.append(ride!)
                                group.leave()
                            }
                        }
                        
                    }
                }
                group.notify(queue: .main) {
                    completionHandler(rides)
                }
            }
        }
    }
    
    //return a user location
    func fetchLocation(location: String, completionHandler: @escaping (LocationModel) -> Void){
        let userID = FirebaseManager.shared.getUserID()
        var dbLocation: String?
        
        if location == "Casa"{
            dbLocation = "home"
        } else if location == "Trabalho"{
            dbLocation = "work"
        } else {
            dbLocation = "institution"
        }
        
        db.collection("users").document(userID).collection("locations").document(dbLocation!).getDocument(){
            (doc, err) in
            let local = LocationModel(locationType: location, latitude: doc!.get("latitude") as! String, longitude: doc!.get("latitude") as! String, address: doc!.get("location") as! String)
            completionHandler(local)
        }
    }

    func sendRideRequest(driverID: String, requestedUserID: String, weekday: String, period: String) {
        // Adds the passenger's userID to driver's
        // array of requested rides on Firestore
        
        print(driverID, requestedUserID, weekday, period)
        
        
        db.collection("drivers").document(requestedUserID).collection("rides")
        .document(weekday).collection(period).document("infos").updateData([
            "requested": FieldValue.arrayUnion([driverID])])
        
        print("entrou")
    }
    
    func removeRideRequest(driverID: String, requestedUserID: String, weekday: String, period: String) {
        // Adds the passenger's userID to driver's
        // array of requested rides on Firestore
        
        db.collection("drivers").document(driverID).collection("rides")
        .document(weekday).collection(period).document("infos").updateData([
            "requested": FieldValue.arrayRemove([requestedUserID])])
    }
    
    func checkResquestedRide(driverID: String, requestedUserID: String, weekday: String, period: String) -> [String] {
        
        db.collection("drivers").document(driverID).collection("rides")
            .document(weekday).collection(period).document("infos").getDocument { (document, error) in
                        if let document = document, document.exists {
                            self.requestedArray = document.get("requested") as? [String] ?? [""]
                        } else {
                            print("Document does not exist")
                    }
            }
        
        return requestedArray
        
//        db.collection("Fruits")
//        .whereField("vitamins", arrayContains: "B6")
//        .whereField("vitamins", arrayContains: "C")
        
    }
    
    func addConfirmedRide(driverID: String, requestedUserID: String, weekday: String, period: String) {
        // Adds the passenger's userID to driver's
        // array of confirmed rides on Firestore
        
        db.collection("drivers").document(driverID).collection("rides")
        .document(weekday).collection(period).document("infos").updateData([
            "confirmedRides": requestedUserID])
    }
    
    //return an array of requested rides
    func fetchRequestsRides(userID: String, type: String, completionHandler: @escaping ([RideModel]) -> Void){
    
        let group = DispatchGroup()
        let days = ["Seg", "Ter", "Qua", "Qui", "Sex"]
        let periods = ["Manhã", "Tarde", "Noite"]
        var ids: [String]?
        var rides: [RideModel]?
        let path = db.collection(type).document(userID).collection("rides")
        
        self.requests = []
        //get rides drivers or passengers user IDs
        for day in days {
            for period in periods {
                group.enter()
                path.document(day).collection(period).document("infos").getDocument { (document, err) in
                  
                    var array = document?.get("requested") as! [String]
                    if array.count > 1 {
                        for item in array{
                            if item != ""{
                                let request = RequestModel(userID: item, day: day, period: period)
                                self.requests.append(request)
                            }
                        }
                    }
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            rides = []
            var type2: String?
            if type == "drivers"{
                type2 = "passengers"
            } else {
                type2 = "drivers"
            }

            for request in self.requests{
                group.enter()
                self.fetchDailyRide(type: type2!, userID: request.userID, weekDay: request.day, period: request.period){ result in
                    rides?.append(result)
                    group.leave()

                }
            }
            
            group.notify(queue: .main) {
                completionHandler(rides!)
            }
        }
        
    }
    
}
