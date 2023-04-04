//
//  APODCacheRepositoryMock.swift
//  APODTests
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import Foundation
@testable import APOD

final class APODCacheRepositoryMock: APODCachableRepository {
    private var data: APODResponseModel!

    func cacheAPOD(_ apodData: Encodable) {
        data = apodData as? APODResponseModel
    }

    func fetchAPOD(requestData: APOD.APODRequestModel) async throws -> APOD.APODData {
        if data != nil {
            return data
        } else {
            throw NSError(domain: "com.nocache.apod", code: 1000)
        }
    }
}
