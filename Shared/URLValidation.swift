//
//  URLValidation.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 13/08/2023.
//

import Foundation

public func convert(webUrlString string: String?) throws -> URL {
    guard let string else {
        throw URLError(.badURL)
    }
    
    var components = URLComponents(string: string)
    guard components != nil else {
        throw URLError(.badURL)
    }
    
    if let scheme = components!.scheme {
        switch scheme {
        case "http", "https":
            ()
        default:
            throw URLError(.badURL)
        }
    } else {
        components!.scheme = "https"
    }
    
    return components!.url!
}
