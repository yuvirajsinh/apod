//
//  APODEndpoint.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import Foundation

/// Endpoints for getting the Astronomy Picture of the Day by NASA
enum APODEndpoint {
    case apod(reqData: APODRequestModel)
}

extension APODEndpoint: Endpoint {
    var baseURL: String {
        return nasaBaseURL
    }

    var path: String {
        switch self {
        case .apod:
            return "/planetary/apod"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .apod:
            return .get
        }
    }

    var headers: HTTPHeaders {
        return defaultHeaders
    }

    var queryParams: Parameters? {
        switch self {
        case .apod(let reqData):
            var json = reqData.toJSON()
            json["api_key"] = "u47RJ0a4gVNONg1tjPbUNsa6ruMvGPxdLbhhzXeZ"
            return json
        }
    }
}
