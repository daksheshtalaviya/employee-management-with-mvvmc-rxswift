//
//  UIView+Extensions.swift
//  EmployeeManagement
//
//  Created by Dksh on 27/05/23.
//

import UIKit

extension UIView {
    
    var sceneDelegate: SceneDelegate? {
        self.window?.windowScene?.delegate as? SceneDelegate
    }
}
