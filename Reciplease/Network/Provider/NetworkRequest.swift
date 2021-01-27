//
//  FakeNetworkResponse.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 18/12/2020.
//

import Foundation
import Alamofire

protocol NetworkRequest {
    func get(_ url: URL, callback: @escaping (Result<Data, NetworkError>) -> Void)
}

class AlamofireNetworkRequest: NetworkRequest {

    func get(_ url: URL, callback: @escaping (Result<Data, NetworkError>) -> Void) {
        AF.request(url).validate().responseData { (response) in
            guard response.error == nil else { return callback(.failure(.hasError)) }
            guard let data = response.data else { return callback(.failure(.emptyData)) }
            callback(.success(data))
        }
    }
}
