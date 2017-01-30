//
//  Package.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 13/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "Mockingbird",
    targets: [
        Target(name: "MockServer",
               dependencies: [.Target(name: "MockServerKit")]),
        Target(name: "MockServerKit",
               dependencies: [.Target(name: "SwaggerKit"),
                              .Target(name: "ResourceKit")]),
        Target(name: "SwaggerKitTests",
               dependencies: [.Target(name: "ResourceKit"),
                              .Target(name: "SwaggerKit"),
                              .Target(name: "TestKit")])
    ],
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 6),
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 6),
        .Package(url: "https://github.com/IBM-Swift/Swift-cfenv.git", majorVersion: 2, minor: 0)
    ]
)
