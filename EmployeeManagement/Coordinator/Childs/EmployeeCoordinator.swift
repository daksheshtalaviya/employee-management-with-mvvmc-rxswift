//
//  EmployeeCoordinator.swift
//  EmployeeManagement
//
//  Created by Dksh on 27/05/23.
//

import UIKit

class EmployeeCoordinator : BaseCoordinator {

    var navigationController: UINavigationController?
    let company: Company
    let employee: Employee

    init(company: Company, employee: Employee, navigationController : UINavigationController?) {
        self.navigationController = navigationController
        self.company = company
        self.employee = employee
    }

    override func start() {

        let viewController = EmployeeDetailViewController(nibName: "EmployeeDetailViewController", bundle: nil)
        viewController.coordinator = self
        viewController.didTapBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            self?.isCompleted?()
        }

        navigationController?.pushViewController(viewController, animated: true)
    }

}
