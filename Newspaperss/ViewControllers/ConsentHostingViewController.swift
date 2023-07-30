//
//  ConsentHostingViewController.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 30/07/2023.
//

import UIKit
import SwiftUI
import UserMessagingPlatform

final class ConsentHostingViewController<Content>: UIHostingController<Content> where Content: View {
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a UMPRequestParameters object.
        let parameters = UMPRequestParameters()
        // Set tag for under age of consent. false means users are not under age
        // of consent.
        parameters.tagForUnderAgeOfConsent = false
        
        // Request an update for the consent information.
        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters) {
            [weak self] requestConsentError in
            guard let self else { return }
            
            if let consentError = requestConsentError {
                // Consent gathering failed.
                return print("Error: \(consentError.localizedDescription)")
            }
            
            UMPConsentForm.loadAndPresentIfRequired(from: self) {
                [weak self] loadAndPresentError in
                guard let self else { return }
                
                if let consentError = loadAndPresentError {
                    // Consent gathering failed.
                    return print("Error: \(consentError.localizedDescription)")
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
