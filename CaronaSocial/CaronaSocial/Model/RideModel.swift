//
//  RideModel.swift
//  CaronaSocial
//
//  Created by Marina Miranda Aranha on 27/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Point{
    var latitude: String
    var longitude: String
}

struct RideModel {
    let userID: String
    let time: String
    let origin: String
    let destiny: String
    let originPoint: Point
    let destinyPoint: Point
    let vacant: String
    let accessibility: String
    let observation: String
    let originType: String
    let destinyType: String
    

    // Standard init
    init(userID: String, time: String, origin: String, destiny: String, originPoint: Point, destinyPoint: Point, vacant: String, accessibility: String, observation: String, originType: String, destinyType: String) {
        self.userID = userID
        self.time = time
        self.origin = origin
        self.destiny = destiny
        self.originPoint = originPoint
        self.destinyPoint = destinyPoint
        self.vacant = vacant
        self.accessibility = accessibility
        self.observation = observation
        self.originType = originType
        self.destinyType = destinyType
    }

    // Func converting model for easier writing to database
    func toAnyObject() -> Any {
        return [
            "user-id": userID,
            "time": time,
            "origin": origin,
            "destiny": destiny,
            "originPoint": originPoint,
            "destinyPoint": destinyPoint,
            "vacant": vacant,
            "accessibility": accessibility,
            "observation": observation,
            "originType": originType,
            "destinyType": destinyType
        ]
    }
}
