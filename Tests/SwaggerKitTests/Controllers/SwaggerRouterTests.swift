//
//  SwaggerRouterTests.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 19/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//


// swiftlint:disable redundant_discardable_let


import Foundation
import ResourceKit
@testable import SwaggerKit
import TestKit
import XCTest

final class SwaggerRouterTests: LoggedTestCase {


    // MARK: - Tests

    func testInit_Success_ValidURL() {
        do {
            let _ = try SwaggerRouter(swaggerURL: ResourceHandler.swaggerSampleURL)
        } catch {
            XCTFail("Expected `SwaggerRouterTests.init(swaggerURL:)` to be successful." +
                    "Failed with error: \(error.localizedDescription)")
        }
    }

    func testInit_Success_InvalidURL() {
        do {
            let _ = try SwaggerRouter(swaggerURL: URL(fileURLWithPath: ""))
        } catch {
            XCTFail("Expected `SwaggerRouterTests.init(swaggerURL:)` to be successful." +
                "Failed with error: \(error.localizedDescription)")
        }
    }

}

extension SwaggerRouterTests {

    static var allTests: [(String, (SwaggerRouterTests) -> () throws -> Void)] {
        return [
            ("testInit_Success_ValidURL", testInit_Success_ValidURL),
            ("testInit_Success_InvalidURL", testInit_Success_InvalidURL)
        ]
    }

}
