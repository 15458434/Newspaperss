//
//  GADAdapterStatusKey.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 04/08/2023.
//

import UIKit
import SwiftUI
import GoogleMobileAds

/// An Environment that passes on the GADAdapterStatus to all the SwiftUI views.
struct GADAdapterStatusKey: EnvironmentKey {
    static var defaultValue: GADAdapterStatus? = nil
}

extension EnvironmentValues {
    var googleAdapterState: GADAdapterStatus? {
        get { self[GADAdapterStatusKey.self] }
        set { self[GADAdapterStatusKey.self] = newValue }
    }
}
