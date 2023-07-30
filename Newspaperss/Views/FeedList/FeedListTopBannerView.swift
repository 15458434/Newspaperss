//
//  FeedListTopBannerView.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 30/07/2023.
//

import UIKit
import SwiftUI
import GoogleMobileAds

struct FeedListTopBannerView: UIViewControllerRepresentable {
    @State private var viewWidth: CGFloat = .zero
    private let bannerView = GADBannerView()
    let adUnitID = "ca-app-pub-5354415674074435/1457583832"
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let bannerViewController = BannerViewController()
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = bannerViewController
        bannerViewController.view.addSubview(bannerView)
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
    
    class Coordinator: NSObject, BannerViewControllerWidthDelegate {
        let parent: FeedListTopBannerView
        
        init(_ parent: FeedListTopBannerView) {
            self.parent = parent
        }
        
        // MARK: - BannerViewControllerWidthDelegate methods
        
        func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat) {
            // Pass the viewWidth from Coordinator to BannerView.
            parent.viewWidth = width
        }
    }
}
