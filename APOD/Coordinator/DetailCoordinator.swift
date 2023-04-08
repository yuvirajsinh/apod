//
//  DetailCoordinator.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 07/04/23.
//

import UIKit

class DetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    var parentCoordinator: MainCoordinator?
    var image: UIImage

    init(childCoordinators: [Coordinator] = [], navigationController: UINavigationController, image: UIImage) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
        self.image = image
    }

    func start() {
        let builder = PhotoDetailBuilder(dependency: PhotoDetailDependency(image: image), coordinator: self)
        let detailVC = builder.build()

        let navVC = UINavigationController(rootViewController: detailVC)

        navigationController.present(navVC, animated: true)
//        navigationController.show(detailVC, sender: self)
    }

    func didSawImage() {
        parentCoordinator?.childDidFinish(self)
    }
}
