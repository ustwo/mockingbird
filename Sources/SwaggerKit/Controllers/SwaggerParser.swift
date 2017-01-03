//
//  SwaggerParser.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 14/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import Foundation
import LoggerAPI

public struct SwaggerParser {


    // MARK: - Properties

    let endpoints: [Endpoint]


    // MARK: - Initializers

    public init?(url: URL) throws {
        let data = try Data(contentsOf: url)

        let jsonRaw = try JSONSerialization.jsonObject(with: data)

        guard let json = jsonRaw as? [String: Any] else {
            return nil
        }

        endpoints = SwaggerParser.parseEndpoints(json: json)
    }


    // MARK: - Parsing

    private static func parseEndpoints(json: [String: Any]) -> [Endpoint] {
        var result: [Endpoint] = []

        guard let pathsJSON = json["paths"] as? [String: [String: [String: Any]]] else {
            return result
        }

        for (path, pathJSON) in pathsJSON {
            for (method, methodJSON) in pathJSON {
                guard let httpMethod = HTTPMethod(rawValue: method.uppercased()) else {
                    Log.warning("Unknown HTTPMethod for path: \(path) with method: \(method)")
                    continue
                }

                let summary = (methodJSON["summary"] as? String) ?? ""

                let endpoint = Endpoint(method: httpMethod,
                                        path: path,
                                        summary: summary)

                result.append(endpoint)
            }
        }

        return result
    }

}
