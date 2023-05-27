//
//  LoginCoordinator.swift
//  EmployeeManagement
//
//  Created by Dksh on 27/05/23.
//

import UIKit

class LoginCoordinator : BaseCoordinator {

    var navigationController: UINavigationController?
    let company: Company

    init(company: Company, navigationController : UINavigationController?) {
        self.navigationController = navigationController
        self.company = company
    }

    override func start() {

        let viewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        viewController.coordinator = self
        
        // if user navigates back, view should be released, so does the coordinator, flow is completed
        viewController.didTapBack = { [weak self] in
            self?.isCompleted?()
        }

        navigationController?.pushViewController(viewController, animated: true)
    }

    // we can go further in our flow if we need to
    func showDetail(_ company: Company, in navigationController: UINavigationController? = nil) {
        let newCoordinator = EmployeeListCoordinator(company: company, navigationController: navigationController ?? self.navigationController)
        newCoordinator.start()
        store(coordinator: newCoordinator)
    }
}
