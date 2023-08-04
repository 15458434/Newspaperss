//
//  FeedSourceTopBannerView.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 30/07/2023.
//

import UIKit
import SwiftUI
import GoogleMobileAds

struct FeedSourceTopBannerView: UIViewControllerRepresentable {
    @State private var viewWidth: CGFloat = .zero
    private let bannerView = GADBannerView()
    let adUnitID = "ca-app-pub-5354415674074435/4881554026"
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let bannerViewController = BannerViewController()
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = bannerViewController
        bannerView.delegate = context.coordinator
        bannerViewController.apply(bannerView)
        bannerViewController.delegate = context.coordinator
        
        return bannerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard viewWidth != .zero else { return }
        
        // Request a banner ad with the updated viewWidth.
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView.load(GADRequest())
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, BannerViewControllerWidthDelegate, GADBannerViewDelegate {
        let parent: FeedSourceTopBannerView
        
        init(_ parent: FeedSourceTopBannerView) {
            self.parent = parent
        }
        
        // MARK: GADBannerViewDelegate
        
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            debugPrint("✅ adViewDidReceiveAd: \(String(describing: bannerView.responseInfo?.responseIdentifier)) for \(String(describing: bannerView.responseInfo?.loadedAdNetworkResponseInfo?.adNetworkClassName))")
        }
        
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            debugPrint("❌ didFailToReceiveAdWithError: \(error)")
        }
        
        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
            debugPrint("bannerViewWillPresentScreen: \(String(describing: bannerView.responseInfo?.responseIdentifier)) for \(String(describing: bannerView.responseInfo?.loadedAdNetworkResponseInfo?.adNetworkClassName))")
        }
        
        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
            debugPrint("bannerViewWillDismissScreen: \(String(describing: bannerView.responseInfo?.responseIdentifier)) for \(String(describing: bannerView.responseInfo?.loadedAdNetworkResponseInfo?.adNetworkClassName))")
        }
        
        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
            debugPrint("bannerViewDidDismissScreen: \(String(describing: bannerView.responseInfo?.responseIdentifier)) for \(String(describing: bannerView.responseInfo?.loadedAdNetworkResponseInfo?.adNetworkClassName))")
        }
        
        func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
            debugPrint("adViewWillLeaveApplication: \(String(describing: bannerView.responseInfo?.responseIdentifier)) for \(String(describing: bannerView.responseInfo?.loadedAdNetworkResponseInfo?.adNetworkClassName))")
        }
        
        // MARK: BannerViewControllerWidthDelegate methods
        
        func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat) {
            // Pass the viewWidth from Coordinator to BannerView.
            parent.viewWidth = width
        }
    }
}
