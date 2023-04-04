//
//  APODCacheRepository.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import Foundation

enum APODCacheError: Error {
    case cacheNotFound
}

final class APODCacheRepository: APODCachableRepository {
    private let cache: ImageCache = ImageCache()
    private let kLatestApod = "latest_apod"

    func fetchAPOD(requestData: APODRequestModel) async throws -> APODData {
        guard let data = UserDefaults.standard.object(forKey: kLatestApod) as? Data else {
            throw APODCacheError.cacheNotFound
        }
        let apodData = try JSONDecoder().decode(APODResponseModel.self, from: data)
        return apodData
    }

    func cacheAPOD(_ apodData: Encodable) {
        guard let data = try? JSONEncoder().encode(apodData) else {
            return
        }
        UserDefaults.standard.set(data, forKey: kLatestApod)
    }
}
