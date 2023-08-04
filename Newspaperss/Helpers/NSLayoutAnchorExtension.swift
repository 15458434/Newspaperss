//
//  NSLayoutAnchorExtension.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 01/08/2023.
//

import UIKit

extension NSLayoutAnchor {
    @objc func constraint(equalTo anchor: NSLayoutAnchor, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let new = self.constraint(equalTo: anchor, constant: c)
        new.priority = p
        return new
    }
}
