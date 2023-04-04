//
//  APODCacheRepositoryTests.swift
//  APODTests
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import XCTest
@testable import APOD

final class APODCacheRepositoryTests: XCTestCase {
    private let cacheRepository: APODCachableRepository = APODCacheRepository()
    private let apodData = APODResponseModel(date: "2023-04-03", explanation: "What causes this unusual curving structure near the center of our Galaxy? The long parallel rays slanting across the top of the featured radio image are known collectively as the Galactic Center Radio Arc and point out from the Galactic plane.  The Radio Arc is connected to the Galactic Center by strange curving filaments known as the Arches.  The bright radio structure at the bottom right surrounds a black hole at the Galactic Center and is known as Sagittarius A*.  One origin hypothesis holds that the Radio Arc and the Arches have their geometry because they contain hot plasma flowing along lines of a constant magnetic field.  Images from NASA\'s Chandra X-ray Observatory appear to show this plasma colliding with a nearby cloud of cold gas.", title: "The Galactic Center Radio Arc")

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func test_apod_cache_data_found() async throws {
        cacheRepository.cacheAPOD(apodData)

        let cachedData = try await cacheRepository.fetchAPOD(requestData: APODRequestModel(date: "2023-04-03"))

        XCTAssertNotNil(cachedData, "Can't fetch cached data")

        XCTAssertEqual(apodData.date, cachedData.date, "Cached data: date does not match")
        XCTAssertEqual(apodData.title, cachedData.title, "Cached data: title does not match")
        XCTAssertEqual(apodData.explanation, cachedData.explanation, "Cached data: explanation does not match")
    }

    func test_apod_cache_data_not_found() async throws {
        cacheRepository.cacheAPOD(apodData)

        let cachedData = try await cacheRepository.fetchAPOD(requestData: APODRequestModel(date: "2023-04-02"))

        XCTAssertNotEqual(cachedData.date, "2023-04-02", "Cached data: not found for the day")
    }
}
