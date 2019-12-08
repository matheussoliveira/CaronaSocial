//
//  LocationModel.swift
//  CaronaSocial
//
//  Created by Marina Miranda Aranha on 08/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct LocationModel {
    
    let locationType: String
    let latitude: String
    let longitude: String
    let address: String

    // Standard init
    init(locationType: String, latitude: String, longitude: String, address: String) {
        self.locationType = locationType
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }

}
