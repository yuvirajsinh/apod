//
//  Encodable+JSON.swift
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import Foundation

public extension Encodable {
    func toJSON(with encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        do {
            let encodedData = try encoder.encode(self)
            let jsonData = try JSONSerialization.jsonObject(with: encodedData, options: [.allowFragments]) as? [String: Any]
            return jsonData ?? [String: Any]()
        } catch {
            return [String: Any]()
        }
    }
}
