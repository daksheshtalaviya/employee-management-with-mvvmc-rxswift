//
//  BaseCoordinator.swift
//  EmployeeManagement
//
//  Created by Dksh on 27/05/23.
//

import Foundation

class BaseCoordinator : Coordinator {
    var childCoordinators : [Coordinator] = []
    var isCompleted: (() -> ())?

    func start() {
        fatalError("Children should implement `start`.")
    }
}
