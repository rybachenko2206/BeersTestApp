//
//  BTError.swift
//  BeersTestApp
//
//  Created by Roman Rybachenko on 25.01.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import Foundation


enum BTError: Error, LocalizedError {
    case custom(String)
    case defaultError
    case invalidToken
    case sessionExpired
    case notFound
    case noResponse
    case connectionLost
    case internalServerError
    
    init(error: Error, statusCode: Int? = nil) {
        guard let code = statusCode else {
            self = .custom(error.localizedDescription)
            return
        }
        switch code {
        case 401:  self = .invalidToken
        case 403: self = .sessionExpired
        case 404: self = .notFound
        case 500: self = .internalServerError
        default: self = .defaultError
        }
    }
    
    var title: String {
        return "Error"
        // can be customized according to rerquirements
    }
    
    var message: String {
        switch self {
        case .custom(let message):
            return message
        case .defaultError:
            return "Something went wrong. Try again later"
        case .invalidToken:
            assertionFailure("shoud not be shown. call refresh token method")
            return "invalid token"
        case .sessionExpired:
            return "Your session is expired. Input login-password to continue"
        case .notFound:
            return "It seems resource is not found... "
        case .noResponse:
            return "The server is not responding"
        case .connectionLost:
            return "Network connection lost. Check you connection and try again"
        case .internalServerError:
            return "server is currently anavailable. Please, try again later"
        }
    }
    
}
