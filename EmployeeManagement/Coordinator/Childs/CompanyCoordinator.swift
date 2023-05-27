//
//  MyCoordinator.swift
//  EmployeeManagement
//
//  Created by Dksh on 27/05/23.
//

import UIKit

class CompanyCoordinator : BaseCoordinator {

    var navigationController: UINavigationController?

    init(navigationController : UINavigationController?) {
        self.navigationController = navigationController
    }

    override func start() {

        let viewController = CompanyListViewController(nibName: "CompanyListViewController", bundle: nil)
        viewController.coordinator = self

        // if user navigates back, view should be released, so does the coordinator, flow is completed
        viewController.didTapBack = { [weak self] in
            self?.isCompleted?()
        }

        navigationController?.pushViewController(viewController, animated: true)
    }

    // we can go further in our flow if we need to
    func showDetail(_ company: Company, in navigationController: UINavigationController? = nil) {
        let newCoordinator = LoginCoordinator(company: company, navigationController: navigationController ?? self.navigationController)
        newCoordinator.start()
        store(coordinator: newCoordinator)
    }
}
