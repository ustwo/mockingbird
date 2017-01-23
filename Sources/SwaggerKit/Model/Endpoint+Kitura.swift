//
//  Endpoint.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 20/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import Foundation
import Kitura

extension Endpoint {


    // MARK: - Properties

    var handler: RouterHandler {
        let summary = self.summary

        return { request, response, next in
                    var responseText = summary

                    if !request.parameters.isEmpty {
                        var parametersList: [String] = []
                        for (key, value) in request.parameters {
                            parametersList.append("- " + key + ": " + value)
                        }
                        responseText += "\n\nParameters:\n" +
                                        parametersList.joined(separator: "\n")
                    }

                    response.send(responseText)
                    next()
                }
    }

    static private let kituraPathRegexString = "\\{([^\\{\\}\\s]+)\\}"

    var kituraPath: String {
        #if os(Linux)
            let regexObj = try? RegularExpression(pattern: Endpoint.kituraPathRegexString,
                                                  options: [])
        #else
            let regexObj = try? NSRegularExpression(pattern: Endpoint.kituraPathRegexString)
        #endif

        guard let regex = regexObj else {
            return ""
        }

        let pathString = NSMutableString(string: path)

        let range = NSRange(location: 0, length:pathString.length)
        let _ = regex.replaceMatches(in: pathString,
                                     options: [],
                                     range: range,
                                     withTemplate: ":$1")

        #if os(Linux)
            return pathString._bridgeToSwift()
        #else
            return pathString as String
        #endif
    }


    // MARK: - Routing

    func add(to router: Router) {
        let path = kituraPath

        switch method {
            case .connect:
                router.connect(path, handler: handler)
            case .delete:
                router.delete(path, handler: handler)
            case .get:
                router.get(path, handler: handler)
            case .head:
                router.head(path, handler: handler)
            case .options:
                router.options(path, handler: handler)
            case .patch:
                router.patch(path, handler: handler)
            case .post:
                router.post(path, handler: handler)
            case .put:
                router.put(path, handler: handler)
            case .trace:
                router.trace(path, handler: handler)
        }
    }

}
