//
//  Endpoint.swift
//
//  Created by Yuvrajsinh Jadeja on 12/02/23.
//

import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var queryParams: Parameters? { get }
    var body: Data? { get }
    var headers: HTTPHeaders { get }
    var mockData: Data? { get }
}

public extension Endpoint {
    var encoding: ParameterEncoding {
        return method == .get ? .URLEncoding : .JSONEncoding
    }

    var queryParams: Parameters? {
        return nil
    }

    var body: Data? {
        return nil
    }

    var mockData: Data? {
        return nil
    }
}
