//
//  URLToStringValueTransformer.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 29/07/2023.
//

import Foundation
import Shared

final class URLToStringValueTransformer: ValueTransformer {
    
    // MARK: ValueTransformer
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override class func transformedValueClass() -> AnyClass {
        return NSURL.self
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let value = value as? String else {
            return nil
        }
        
        return try? transform(webUrlString: value)
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let value = value as? NSURL else {
            return nil
        }
        
        return value.absoluteString
    }
    
    // MARK: NSObject
}

extension NSValueTransformerName {
    static let urlToStringValueTransformerName = NSValueTransformerName(rawValue: "URLToStringValueTransformer")
}
