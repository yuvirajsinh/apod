//
//  MainCoordinator.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 07/04/23.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    init(childCoordinators: [Coordinator] = [], navigationController: UINavigationController) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self

        let builder = HomeBuilder(dependency: HomeDependency(), coordinator: self)
        let homeVC = builder.build()

        navigationController.pushViewController(homeVC, animated: false)
    }

    func showFullImage(image: UIImage) {
        let child = DetailCoordinator(navigationController: navigationController, image: image)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
    }
}

extension MainCoordinator: UINavigationControllerDelegate {
    /*func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we are moving from
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a detail view controller
        if let detailVC = fromViewController as? PhotoDetailViewController {
            childDidFinish(detailVC.coordinator)
        }
    }*/
}
