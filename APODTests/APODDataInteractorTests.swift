//
//  APODDataInteractorTests.swift
//  APODTests
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import XCTest
@testable import APOD

final class APODDataInteractorTests: XCTestCase {
    private let apiRepository: APODAPIRepositoryMock = APODAPIRepositoryMock()
    private let cacheRepository: APODCacheRepositoryMock = APODCacheRepositoryMock()
    private var interactor: APODDataInteractorProtocol?

    override func setUpWithError() throws {
        interactor = APODDataInteractor(apiRepository: apiRepository, cacheRepository: cacheRepository)
    }

    override func tearDownWithError() throws {
        interactor = nil
    }

    func test_APODDataInteractor_dataFetch_success() async throws {
        let apodData = try await interactor?.fetchAPOD(requestData: APODRequestModel(date: "2023-04-03"))

        XCTAssertEqual(apodData?.date, APODResponseModel.mockData.date, "Date should be same")
        XCTAssertEqual(apodData?.title, APODResponseModel.mockData.title, "Title should be same")
        XCTAssertEqual(apodData?.explanation, APODResponseModel.mockData.explanation, "Explanation should be same")
    }
}
