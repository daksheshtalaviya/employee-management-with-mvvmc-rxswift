//
//  Company.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import Foundation

class Company: Codable {
        
    let id: Int
    let name: String
    var employees: [Employee]
    
    internal init(id: Int, name: String, employees: [Employee]) {
        self.id = id
        self.name = name
        self.employees = employees
    }

}
