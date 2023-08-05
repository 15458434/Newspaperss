//
//  BannerViewController.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 30/07/2023.
//

import UIKit
import GoogleMobileAds

protocol BannerViewControllerWidthDelegate: AnyObject {
    func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat)
}

final class BannerViewController: UIViewController {
    weak var delegate: BannerViewControllerWidthDelegate?
    
    func apply(_ bannerView: GADBannerView) {
        self.view.addSubview(bannerView)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        @NSLayoutConstraintBuilder var constraints: [NSLayoutConstraint] {
            view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 0)
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: 0)
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor)
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 0, priority: .almostRequired)
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: UIViewController
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Tell the delegate the initial ad width.
        delegate?.bannerViewController(self, didUpdate: view.frame.inset(by: view.safeAreaInsets).size.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in
            // do nothing
        } completion: { _ in
            // Notify the delegate of ad width changes.
            self.delegate?.bannerViewController(self, didUpdate: self.view.frame.inset(by: self.view.safeAreaInsets).size.width)
        }
    }
    
    // MARK: UIResponder
    
    // MARK: NSObject
}
