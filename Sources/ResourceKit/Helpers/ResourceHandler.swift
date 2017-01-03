//
//  SwaggerParser.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 20/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import Foundation
import LoggerAPI

public struct ResourceHandler {


    // MARK: - Properties

    private static let sampleName = "sample_swagger"
    private static let sampleExtension = "json"
    private static let sampleFullName = ResourceHandler.sampleName + "." + ResourceHandler.sampleExtension

    public static var swaggerSampleURL: URL {
        #if os(Linux)
            // swiftlint:disable:next force_unwrapping
            return URL(string: "file:///root/Resources/" + ResourceHandler.sampleFullName)!
        #else
            // If in Xcode, grab from the resource bundle
            let frameworkBundle = Bundle(for: DummyClass.self)
            if let url = frameworkBundle.url(forResource:ResourceHandler.sampleName,
                                         withExtension: ResourceHandler.sampleExtension) {

                return url
            }

            // If using the Swift compiler (i.e. `swift build` or `swift test`, use the absolute path.
            // swiftlint:disable:next force_unwrapping
            let frameworkURL = Bundle(for: DummyClass.self).resourceURL!
            return frameworkURL.appendingPathComponent("../../../../../Resources/" + ResourceHandler.sampleFullName)
        #endif
    }

}

private class DummyClass: NSObject { }
