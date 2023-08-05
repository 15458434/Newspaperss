//
//  GADTestDevices.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 01/08/2023.
//

import UIKit
import GoogleMobileAds

/// Struct that hold all the identifiers from test devices.
struct GADTestDevices {
    let identifiers: [String]
    
    init() {
        let iPhone11ProMarkID = "e1e7c0fe434a85ce976f84098f5ce9d2"
        self.identifiers = [ GADSimulatorID, iPhone11ProMarkID]
    }
}
