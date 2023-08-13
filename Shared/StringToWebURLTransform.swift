//
//  StringToWebURLTransform.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 13/08/2023.
//

import Foundation

public func transform(webUrlString string: String?) throws -> URL {
    guard let string else {
        throw URLError(.badURL)
    }
    
    guard let url = URL(string: string) else {
        throw URLError(.badURL)
    }
    
    if url.host == nil {
        let path = url.pathComponents.dropFirst().reduce("") { partialResult, pathComponent in
            return "\(partialResult)/\(pathComponent)"
        }
        let hostComponent = url.pathComponents.first
        var urlComponents = URLComponents()
        urlComponents.host = hostComponent
        urlComponents.scheme = "https"
        urlComponents.path = path
        return urlComponents.url!
    }
    
    if let scheme = url.scheme {
        switch scheme {
        case "http", "https":
            ()
        default:
            throw URLError(.unsupportedURL)
        }
    } else {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components!.scheme = "https"
    }
    
    return url
}
