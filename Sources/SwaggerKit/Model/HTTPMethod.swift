//
//  HTTPMethod.swift
//  Mockingbird
//
//  Created by Aaron McTavish on 20/12/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import Foundation

enum HTTPMethod: String {

    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"

    static let allValues: [HTTPMethod] = [.connect, .delete, .get, .head, .options,
                                          .patch, .post, .put, .trace]

}
