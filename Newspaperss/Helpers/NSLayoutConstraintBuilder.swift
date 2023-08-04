//
//  NSLayoutConstraintBuilder.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 01/08/2023.
//

import UIKit

@resultBuilder
struct NSLayoutConstraintBuilder {
    static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        return components
    }
    
    static func buildBlock(_ components: [NSLayoutConstraint]...) -> [NSLayoutConstraint] {
        components.flatMap { $0 }
    }

    /// Add support for both single and collections of constraints.
    static func buildExpression(_ expression: NSLayoutConstraint) -> [NSLayoutConstraint] {
        [expression]
    }

    static func buildExpression(_ expression: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        expression
    }
    
    /// Add support for optionals.
    static func buildOptional(_ components: [NSLayoutConstraint]?) -> [NSLayoutConstraint] {
        components ?? []
    }
    
    /// Add support for if statements.
    static func buildEither(first components: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        components
    }

    static func buildEither(second components: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        components
    }
    
    /// Add support for loops.
    static func buildArray(_ components: [[NSLayoutConstraint]]) -> [NSLayoutConstraint] {
        components.flatMap { $0 }
    }
    
    /// Add support for #availability checks.
    static func buildLimitedAvailability(_ components: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        components
    }
}
