//
//  AppCoordinator.swift
//  EmployeeManagement
//
//  Created by Dksh on 27/05/23.
//

import UIKit

class AppCoordinator : BaseCoordinator {

    let window : UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {
        // preparing root view
        let navigationController = UINavigationController()
        let coordinator = CompanyCoordinator(navigationController: navigationController)

        // store child coordinator
        self.store(coordinator: coordinator)
        coordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        // detect when free it
        coordinator.isCompleted = { [weak self] in
            self?.free(coordinator: coordinator)
        }
        
        AppManager.shared.databaseManager.saveDataToDirectory()
    }
}
