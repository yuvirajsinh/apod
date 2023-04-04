//
//  APODRepository.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import Foundation

protocol APODRepository {
    func fetchAPOD(requestData: APODRequestModel) async throws -> APODData
}

protocol APODCachableRepository: APODRepository {
    func cacheAPOD(_ apodData: Encodable)
}

