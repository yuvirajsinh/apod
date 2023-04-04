//
//  HomeBuilder.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import UIKit

struct HomeDependency {

}

struct HomeBuilder {
    let dependency: HomeDependency

    func build() -> UIViewController {
        let dataInteractor = APODDataInteractor(
            apiRepository: APODAPIRepository(apiManager: APIManager()),
            cacheRepository: APODCacheRepository()
        )
        let viewModel = HomeViewModel(dependency: dependency, dataInteractor: dataInteractor)
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.presenter = viewController
        return viewController
    }
}
