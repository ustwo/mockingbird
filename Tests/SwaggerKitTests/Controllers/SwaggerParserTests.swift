//
//  SwaggerParserTests.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 19/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import Foundation
import ResourceKit
@testable import SwaggerKit
import TestKit
import XCTest

final class SwaggerParserTests: LoggedTestCase {


    // MARK: - Tests

    func testInit_Success() {
        do {
            let swaggerURL = ResourceHandler.swaggerSampleURL
            let parser = try SwaggerParser(url: swaggerURL)

            XCTAssertNotNil(parser,
                            "Expected `SwaggerParser.init(url:)` to be not `nil`.")

            XCTAssertFalse(parser?.endpoints.isEmpty ?? true,
                           "Expected `SwaggerParser` to contain endpoints, but found none.")
        } catch {
            XCTFail("Expected `SwaggerParser.init(url:)` to be successful." +
                    "Failed with error: \(error.localizedDescription)")
        }
    }

    func testInit_Failure_InvalidURL() {
        XCTAssertThrowsError(try SwaggerParser(url: URL(fileURLWithPath: "")))
    }

}

extension SwaggerParserTests {

    static var allTests: [(String, (SwaggerParserTests) -> () throws -> Void)] {
        return [
            ("testInit_Success", testInit_Success),
            ("testInit_Failure_InvalidURL", testInit_Failure_InvalidURL)
        ]
    }

}
