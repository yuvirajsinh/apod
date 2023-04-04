//
//  APODDataInteractor.swift
//  NAPOD
//
//  Created by Yuvrajsinh Jadeja on 03/04/23.
//

import Foundation

final class APODDataInteractor: APODDataInteractorProtocol {
    var apiRepository: APODRepository
    var cacheRepository: APODCachableRepository
    private var apodData: APODData?

    init(apiRepository: APODRepository, cacheRepository: APODCachableRepository) {
        self.apiRepository = apiRepository
        self.cacheRepository = cacheRepository
    }

    func fetchAPOD(requestData: APODRequestModel) async throws -> APODData {
        // Try to get it from cache
        if let cacheData = await fetchFromCache(requestData: requestData) {
            apodData = cacheData
            if cacheData.date == requestData.date {
                return cacheData
            }
        }

        // Fetch from API
        do {
            let newData = try await fetchFromAPI(requestData: requestData)
            saveToCache(apodData: newData as! Encodable)
            return newData
        } catch {
            guard let oldData = apodData else {
                throw error
            }
            throw APODDataInteractorError.oldDataFound(oldData)
        }
    }

    private func fetchFromCache(requestData: APODRequestModel) async -> APODData? {
        return try? await cacheRepository.fetchAPOD(requestData: requestData)
    }

    private func fetchFromAPI(requestData: APODRequestModel) async throws -> APODData {
        return try await apiRepository.fetchAPOD(requestData: requestData)
    }

    private func saveToCache(apodData: Encodable) {
        cacheRepository.cacheAPOD(apodData)
    }
}
