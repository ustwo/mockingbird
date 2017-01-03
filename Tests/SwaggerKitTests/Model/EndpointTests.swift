//
//  EndpointTests.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 20/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import Dispatch
import Kitura
import KituraNet
@testable import SwaggerKit
import TestKit
import XCTest

final class EndpointTests: LoggedTestCase {


    // MARK: - Properties

    var router: Router!

    // swiftlint:disable:next number_separator
    let port = 8090


    // MARK: - Set Up & Tear Down

    override func setUp() {
        super.setUp()

        router = Router()
        Kitura.addHTTPServer(onPort: port, with: router)
        Kitura.start()
    }

    override func tearDown() {
        super.tearDown()

        Kitura.stop()
    }


    // MARK: - Tests

    func testKituraPath() {
        // Given
        let endpoint = Endpoint(method: .get, path: "/foo/{bar}/baz", summary: "")
        let expectedResult = "/foo/:bar/baz"

        // When
        let actualResult = endpoint.kituraPath

        // Then
        XCTAssertEqual(actualResult,
                       expectedResult,
                       "Expected: \(expectedResult) but instead found: \(actualResult)")
    }

    func testAdd_ToRouter_NoParameters() {
        // Given
        let method = HTTPMethod.get
        let path = "/foo"
        let endpoint = Endpoint(method: method, path: path, summary: "Summary")
        let expectedResult = "Summary"

        // When
        endpoint.add(to: router)

        // Then
        requestTest(method: method, path: path, expectedResult: expectedResult)
    }

    func testAdd_ToRouter_Parameters() {
        // Given
        let method = HTTPMethod.get
        let path = "/foo/{bar}/baz"
        let endpoint = Endpoint(method: method, path: path, summary: "Summary")
        let expectedResult = "Summary\n\nParameters:\n- bar: 123"

        // When
        endpoint.add(to: router)

        // Then
        requestTest(method: method, path: "/foo/123/baz", expectedResult: expectedResult)
    }


    // MARK: - Convenience

    private func requestTest(method: HTTPMethod, path: String, expectedResult: String) {
        let expect = expectation(description: "RoutingExpectation")
        let options: [ClientRequest.Options] = [.method(method.rawValue), .hostname("localhost"),
                                                .port(Int16(port)), .path(path)]

        let request = HTTP.request(options) { response in
            defer {
                expect.fulfill()
            }

            guard let response = response,
                let actualResult = try? response.readString()  else {

                    XCTFail("Received empty or nil response.")
                    return
            }

            XCTAssertEqual(actualResult,
                           expectedResult,
                           "Expected: \(expectedResult) but instead found: \(actualResult)")
        }

        DispatchQueue.main.async {
            request.end()
        }
        waitForExpectations(timeout: 2.0)
    }

}

extension EndpointTests {

    static var allTests: [(String, (EndpointTests) -> () throws -> Void)] {
        return [
            ("testKituraPath", testKituraPath),
            ("testAdd_ToRouter_NoParameters", testAdd_ToRouter_NoParameters),
            ("testAdd_ToRouter_Parameters", testAdd_ToRouter_Parameters)
        ]
    }

}
