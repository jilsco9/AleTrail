//
//  NetworkingError.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/24/25.
//

import Foundation

enum NetworkingError: Error {
    
    case decodingError(DecodingError)
    case urlError(URLError)
    // case failureStatus(statusCode: Int)
    case other(Error) // TODO: distinct from other types of errors? or make this specific to our network status codes?
}
