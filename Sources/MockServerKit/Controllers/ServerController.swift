//
//  ServerController.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 19/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

// swiftlint:disable sorted_imports
#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

import Foundation
import HeliumLogger
import Kitura
import LoggerAPI
import ResourceKit
import SwaggerKit

/// Manages the operations of the HTTP server.
public final class ServerController {


    /// Initializes a new `ServerController`.
    public init() { }


    // MARK: - Start & Stop

    /// Starts the HTTP server.
    public func start(swaggerURL: URL = ResourceHandler.swaggerSampleURL) {
        do {
            setbuf(stdout, nil)
            HeliumLogger.use(LoggerMessageType.verbose)

            let router = try SwaggerRouter(swaggerURL: swaggerURL)
            Log.info("Server will be started on '\(router.url)'")

            Kitura.addHTTPServer(onPort: router.port, with: router.router)

            Kitura.run()
        } catch {
//            Log.error(error.localizedDescription)
            Log.error("Server did not start!")
        }
    }

}
