//
//  Array+Extensions.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
