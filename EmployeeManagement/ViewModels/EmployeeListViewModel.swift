//
//  EmployeeListViewModel.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import Foundation
import RxSwift
import RxCocoa

class EmployeeListViewModel {
    
    private let companyDataManager: DatabaseManager
    private let company: Company
    private let disposeBag = DisposeBag()
    
    let employees: BehaviorRelay<[Employee]> = .init(value: [])
    
    init(companyDataManager: DatabaseManager, company: Company) {
        self.companyDataManager = companyDataManager
        self.company = company
        
        loadEmployees()
    }
    
    func employee(at index: Int) -> Employee? {
        return employees.value[safe: index]
    }
    
    func loadEmployees() {
        self.employees.accept(company.employees)
    }
    
    func addEmployee(_ employee: Employee) {
        // Add the employee to the list
        var updatedEmployees = employees.value
        updatedEmployees.append(employee)
        employees.accept(updatedEmployees)
    }
}
