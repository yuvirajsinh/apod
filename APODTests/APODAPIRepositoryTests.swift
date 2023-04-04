//
//  APODAPIRepositoryTests.swift
//  APODTests
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import XCTest
@testable import APOD

final class APODAPIRepositoryTests: XCTestCase {
    private let apiRepository: APODRepository = APODAPIRepository(apiManager: APIManager())

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func test_APODAPIRepository_fetchData_success() async throws {
        let expectation = XCTestExpectation(description: "APOD API should success")
        do {
            let apodData = try await apiRepository.fetchAPOD(requestData: APODRequestModel(date: "2023-04-03"))

            XCTAssertNotNil(apodData.date, "API DATA: date should not be nil")
            XCTAssertNotNil(apodData.title, "API DATA: title should not be nil")
            XCTAssertNotNil(apodData.explanation, "API DATA: explanation should not be nil")
            XCTAssertNotNil(apodData.hdurl, "API DATA: hdurl should not be nil")

            XCTAssertEqual(apodData.date, "2023-04-03", "API DATA: Date does not match")
            XCTAssertEqual(apodData.title, "The Galactic Center Radio Arc", "API DATA: Title does not match")
            XCTAssertEqual(apodData.explanation, "What causes this unusual curving structure near the center of our Galaxy? The long parallel rays slanting across the top of the featured radio image are known collectively as the Galactic Center Radio Arc and point out from the Galactic plane.  The Radio Arc is connected to the Galactic Center by strange curving filaments known as the Arches.  The bright radio structure at the bottom right surrounds a black hole at the Galactic Center and is known as Sagittarius A*.  One origin hypothesis holds that the Radio Arc and the Arches have their geometry because they contain hot plasma flowing along lines of a constant magnetic field.  Images from NASA\'s Chandra X-ray Observatory appear to show this plasma colliding with a nearby cloud of cold gas.", "API DATA: Explanation is doesn not match")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func test_APODAPIRepository_fetchData_failure() async throws {
        let expectation = XCTestExpectation(description: "APOD API should fail")
        do {
            _ = try await apiRepository.fetchAPOD(requestData: APODRequestModel(date: "2050-04-03"))
        } catch {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }
}
