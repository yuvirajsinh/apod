//
//  APODAPIRepository.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import Foundation
import Combine

final class APODAPIRepository: APODRepository {
    private let apiManager: APIManager

    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }

    func fetchAPOD(requestData: APODRequestModel) async throws -> APODData {
        return try await withCheckedThrowingContinuation { continuation in
            apiManager.execute(APODEndpoint.apod(reqData: requestData)) { (result: Result<APODResponseModel, Error>) in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)

                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
