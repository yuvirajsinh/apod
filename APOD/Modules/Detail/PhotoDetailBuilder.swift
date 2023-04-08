//
//  PhotoDetailBuilder.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import UIKit

struct PhotoDetailDependency {
    let image: UIImage
}

struct PhotoDetailBuilder {
    let dependency: PhotoDetailDependency
    let coordinator: DetailCoordinator?

    func build() -> UIViewController {
        let viewModel = PhotoDetailViewModel(dependency: dependency)
        let viewController = PhotoDetailViewController(viewModel: viewModel)
        viewModel.presenter = viewController
        viewModel.coordinator = coordinator
        return viewController
    }
}
