//
//  HomeViewModelTests.swift
//  APODTests
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import XCTest
@testable import APOD

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel?
    private let startLoadingExpectation = XCTestExpectation(description: "startLoading expectation")
    private let stopLoadingExpectation = XCTestExpectation(description: "stopLoading expectation")
    private let setDataExpectation = XCTestExpectation(description: "setData expectation")

    override func setUpWithError() throws {
        viewModel = HomeViewModel(dependency: HomeDependency(), dataInteractor: APODDataInteractor(apiRepository: APODAPIRepositoryMock(), cacheRepository: APODCacheRepositoryMock()))
        viewModel?.presenter = self
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func test_HomeViewModel_StartLoading() {
        viewModel?.fetchAPOD()
        wait(for: [startLoadingExpectation], timeout: 3.0)
    }

    func test_HomeViewModel_StopLoading() {
        viewModel?.fetchAPOD()
        wait(for: [stopLoadingExpectation], timeout: 3.0)
    }

    func test_HomeViewModel_SetData() {
        viewModel?.fetchAPOD()
        wait(for: [setDataExpectation], timeout: 3.0)
    }
}

extension HomeViewModelTests: HomeViewPresenter {
    func startLoading() {
        startLoadingExpectation.fulfill()
    }

    func stopLoading() {
        stopLoadingExpectation.fulfill()
    }

    func setData(_ data: APOD.APODData) {
        setDataExpectation.fulfill()
    }

    func showAlert(title: String?, message: String?) {

    }

    func navigateToFullImage(builder: APOD.PhotoDetailBuilder) {

    }
}
