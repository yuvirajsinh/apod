//
//  APODDataInteractorProtocol.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import Foundation

protocol APODDataInteractorProtocol {
    var apiRepository: APODRepository { get set }
    var cacheRepository: APODCachableRepository { get set }

    func fetchAPOD(requestData: APODRequestModel) async throws -> APODData
}

enum APODDataInteractorError: Error {
    case oldDataFound(_ apodData: APODData)
}
