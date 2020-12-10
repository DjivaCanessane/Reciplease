//
//  NetworkError.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 17/11/2020.
//

import Foundation

enum NetworkError: Error {
    case hasError
    case emptyData
    case imageError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .hasError:
            return "Contains an error."
        case .emptyData:
            return "There is no data."
        case .imageError:
            return "Error when requestiing image data."
        }
    }
}
