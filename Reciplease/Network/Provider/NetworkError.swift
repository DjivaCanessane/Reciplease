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
    case decodingError
    case noIngredients
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .hasError:
            return "Contains an error."
        case .emptyData:
            return "There is no data."
        case .decodingError:
            return "Can not decode data."
        case .noIngredients:
            return "Please enter some indredient before searching."
        }
    }
}
