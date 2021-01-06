//
//  CoreDataError.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 18/12/2020.
//

import Foundation

enum CoreDataError: Error {
    case fetchError
    case saveError
    case nothingToDelete
}

extension CoreDataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fetchError:
            return "Can not fetch data."
        case .saveError:
            return "Can not save."
        case .nothingToDelete:
            return "This URL do not refers to a saved recipe."
        }
    }
}
