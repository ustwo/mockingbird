//
//  LinuxMain.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 13/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

@testable import SwaggerKitTests
import XCTest

XCTMain([
    // Controllers
    testCase(SwaggerParserTests.allTests),
    testCase(SwaggerRouterTests.allTests),
    // Model
    testCase(EndpointTests.allTests)
])
