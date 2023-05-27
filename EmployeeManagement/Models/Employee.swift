//
//  Employee.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import Foundation

class Employee: Codable, Equatable {
    
    let id: Int
    var name: String
    var position: String
    let email: String?
    var isResigned: Bool
    
    var isNew: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name, position, email
        case isResigned = "resigned"
    }
    
    internal init(id: Int, name: String, position: String, email: String? = nil, isResigned: Bool, isNew: Bool = false) {
        self.id = id
        self.name = name
        self.position = position
        self.email = email
        self.isResigned = isResigned
        self.isNew = isNew
    }

    static func ==(lhs: Employee, rhs: Employee) -> Bool {
        lhs.id == rhs.id
    }
}
