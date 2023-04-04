//
//  HomeViewBuilderTests.swift
//  APODTests
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import XCTest
@testable import APOD

final class HomeViewBuilderTests: XCTestCase {
    func test_HomeViewBuilder_Init() throws {
        let builder = HomeBuilder(dependency: HomeDependency())
        let homeVC = builder.build()

        XCTAssertNotNil(builder)
        XCTAssertTrue(homeVC is HomeViewController)
    }
}
