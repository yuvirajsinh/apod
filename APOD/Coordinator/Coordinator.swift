//
//  Coordinator.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 07/04/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
