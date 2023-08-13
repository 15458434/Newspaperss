//
//  URLTests.swift
//  URLTests
//
//  Created by Mark Cornelisse on 13/08/2023.
//

import XCTest
@testable import Shared

final class URLTests: XCTestCase {

    func testStringToURLTransform() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let urlStringNoScheme = "www.nu.nl/rss/Algemeen"
        XCTAssertNoThrow(try transform(webUrlString: urlStringNoScheme))
        XCTAssertEqual("https://www.nu.nl/rss/Algemeen", try? transform(webUrlString: urlStringNoScheme).absoluteString)
        
        let urlStringComplete = "https://iosdevweekly.com/issues.rss"
        XCTAssertNoThrow(try transform(webUrlString: urlStringComplete))
        XCTAssertEqual("https://iosdevweekly.com/issues.rss", try? transform(webUrlString: urlStringComplete).absoluteString)
    }
}
