//
//  API.swift
//
//  Created by Yuvrajsinh Jadeja on 12/02/23.
//

import Foundation

protocol Networking {
    func execute(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

final class API: Networking {
    var urlSession: URLSession

    init(session: URLSession = .shared) {
        urlSession = session
    }

    func execute(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        urlSession.dataTask(with: request, completionHandler: completion)
        .resume()
    }
}

final class MockAPI: Networking {
    private let delay: TimeInterval
    private let queue: DispatchQueue = DispatchQueue.global()

    init(delay: TimeInterval = 2.0) {
        self.delay = delay
    }

    func execute(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        queue.asyncAfter(deadline: .now() + .milliseconds(Int(delay) * 1000), execute: {
            guard let stubFileUrl = Bundle.main.url(forResource: "APODResponseData", withExtension: "json") else {
                completion(nil, nil, nil)
                return
            }
            guard let data = try? Data(contentsOf: stubFileUrl) else {
                completion(nil, nil, nil)
                return
            }
            completion(data, nil, nil)
        })
    }
}

final class APIManager {
    private let networking: Networking
    private let decoder: JSONDecoder
    private let responseQueue: DispatchQueue = .main

    init(networking: Networking = API(), decoder: JSONDecoder = JSONDecoder()) {
        self.networking = networking
        self.decoder = decoder
    }

    func execute<Value: Decodable>(_ request: Endpoint, completion: @escaping (Result<Value, Error>) -> Void) {
        networking.execute(urlRequest(for: request)) { responseData, response, error in
            if let data = responseData {
                do {
                    // debugPrint("Response: \n \(String(data: data, encoding: .utf8))")
                    let response = try self.decoder.decode(Value.self, from: data)
                    self.responseQueue.async {
                        completion(.success(response))
                    }
                } catch {
                    self.responseQueue.async {
                        completion(.failure(error))
                    }
                }
            } else {
                self.responseQueue.async {
                    completion(.failure(error!))
                }
            }
        }
    }

    private func urlRequest(for endpoint: Endpoint) -> URLRequest {
        let url = URL(endpoint)
        var result = URLRequest(url: url)
        result.httpMethod = endpoint.method.rawValue
        result.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        for header in endpoint.headers {
            result.addValue(header.value, forHTTPHeaderField: header.key)
        }

        return result
    }
}


extension URL {
    func url(with queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        components.queryItems = (components.queryItems ?? []) + queryItems
        return components.url!
    }

    init(_ endpoint: Endpoint) {
        var queryItems: [URLQueryItem] = []
        if let params = endpoint.queryParams {
            queryItems = params.map { (key: String, value: Any) in
                URLQueryItem(name: key, value: "\(value)")
            }
        }

        let url = URL(string: endpoint.baseURL)!
            .appendingPathComponent(endpoint.path)
            .url(with: queryItems)

        self.init(string: url.absoluteString)!
    }
}
