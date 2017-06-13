//
//  SwaggerRouter.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 21/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import CloudFoundryEnv
import Configuration
import Foundation
import Kitura
import LoggerAPI

public final class SwaggerRouter {


    // MARK: - Properties

    public let router = Router()

    private let appEnv = ConfigurationManager()
    private let parser: SwaggerParser?

    public var port: Int {
        return appEnv.port
    }

    public var url: String {
        return appEnv.url
    }


    // MARK: - Initializers

    public init(swaggerURL: URL) throws {
        defer {
            router.get("/status", handler: getStatus)
        }

        guard let parser = try? SwaggerParser(url: swaggerURL) else {
            Log.warning("Unable to parse Swagger file at url: " + swaggerURL.absoluteString)
            self.parser = nil
            return
        }

        self.parser = parser

        setUp()
    }


    // MARK: - Set Up

    private func setUp() {
        guard let parser = parser else {
            return
        }

        for endpoint in parser.endpoints {
            endpoint.add(to: router)
        }
    }


    // MARK: - Default Endpoints

    func getStatus(request: RouterRequest, response: RouterResponse,
                   next: @escaping () -> Void) throws {

            defer {
                next()
            }

            Log.debug("GET - /status")
            response.headers["Content-Type"] = "text/plain; charset=utf-8"

            var message = ""

            message += "Parsed Swagger: \(parser != nil)\n"

            message = message.trimmingCharacters(in:.whitespacesAndNewlines)

            try response.status(.OK).send(message).end()
    }

}
