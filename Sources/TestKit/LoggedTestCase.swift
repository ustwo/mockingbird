//
//  LoggedTestCase.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 30/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

import HeliumLogger
import LoggerAPI
import XCTest

open class LoggedTestCase: XCTestCase {


    // MARK: - Set Up / Tear Down

    open override func setUp() {
        super.setUp()

        setbuf(stdout, nil)
        HeliumLogger.use(LoggerMessageType.verbose)
    }

}
