//
//  FakeNetworkRequest.swift
//  RecipleaseTests
//
//  Created by Djiveradjane Canessane on 07/01/2021.
//

@testable import Reciplease
import Foundation

struct FakeRecipeNetworkRequest: NetworkRequest {
    var data: Data?
    var error: Error?
    
    func get(_ url: URL, callback: @escaping (Result<Data, NetworkError>) -> Void) {
        guard error == nil else { return callback(.failure(.hasError)) }
        guard let data = data else { return callback(.failure(.emptyData)) }
        callback(.success(data))
    }
}

class FakeImageNetworkRequestWillFail: NetworkRequest {
    var recipeData: Data? {
        let bundle = Bundle(for: FakeImageNetworkRequestWillFail.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    var error: Error?
    var hasReturnRecipeHit = false
    
    func get(_ url: URL, callback: @escaping (Result<Data, NetworkError>) -> Void) {
        guard error == nil else { return callback(.failure(.hasError)) }
        guard let recipeData = recipeData else { return callback(.failure(.emptyData)) }
        if hasReturnRecipeHit {
            callback(.failure(.emptyData))
        } else {
            hasReturnRecipeHit = true
            callback(.success(recipeData))
        }
       
    }
}

class FakeImageNetworkRequestWillSucceed: NetworkRequest {
    var recipeData: Data? {
        let bundle = Bundle(for: FakeImageNetworkRequestWillFail.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    let imageData = "testImageData".data(using: .utf8)!
    var error: Error?
    var hasReturnRecipeHit = false
    
    func get(_ url: URL, callback: @escaping (Result<Data, NetworkError>) -> Void) {
        guard error == nil else { return callback(.failure(.hasError)) }
        guard let recipeData = recipeData else { return callback(.failure(.emptyData)) }
        if hasReturnRecipeHit {
            callback(.success(imageData))
        } else {
            hasReturnRecipeHit = true
            callback(.success(recipeData))
        }
       
    }
}
