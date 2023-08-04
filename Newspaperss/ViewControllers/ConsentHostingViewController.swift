//
//  ConsentHostingViewController.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 30/07/2023.
//

import UIKit
import SwiftUI
import UserMessagingPlatform
import GoogleMobileAds

final class ConsentHostingViewController<Content>: UIHostingController<Content> where Content: View {
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a UMPRequestParameters object.
        let parameters = UMPRequestParameters()
        let debugSettings = UMPDebugSettings()
        debugSettings.testDeviceIdentifiers = GADTestDevices().identifiers
        parameters.debugSettings = debugSettings
        // Set tag for under age of consent. false means users are not under age
        // of consent.
        parameters.tagForUnderAgeOfConsent = false
        
        // Request an update for the consent information.
        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters) {
            [weak self] requestConsentError in
            guard let self else { return }
            
            if let consentError = requestConsentError {
                // Consent gathering failed.
                debugPrint("Error: \(consentError.localizedDescription)")
                return
            }
            
            UMPConsentForm.loadAndPresentIfRequired(from: self) {
                [weak self] loadAndPresentError in
                guard self != nil else { return }
                
                if let consentError = loadAndPresentError {
                    // Consent gathering failed.
                    debugPrint("Error: \(consentError.localizedDescription)")
                    return
                }
                
                // Consent has been gathered.
                if UMPConsentInformation.sharedInstance.canRequestAds {
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    appDelegate!.startGoogleAds()
                }
            }
        }
    }
    
    // MARK: UIResponder
    
    // MARK: NSObject
}
