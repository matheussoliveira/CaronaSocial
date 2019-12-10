//
//  RequestModel.swift
//  CaronaSocial
//
//  Created by Marina Miranda Aranha on 09/12/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct RequestModel {
    
    let userID: String
    let day: String
    let period: String


    // Standard init
    init(userID: String, day: String, period: String) {
        self.userID = userID
        self.day = day
        self.period = period

    }

}

