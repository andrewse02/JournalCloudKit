//
//  EntryError.swift
//  Journal-CK
//
//  Created by Andrew Elliott on 4/11/22.
//

import Foundation

enum EntryError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescriptions: String? {
        switch self {
        case .invalidURL:
            return "Internal error. Please update Journal or contact support."
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The server responded with bad data."
        }
    }
}
