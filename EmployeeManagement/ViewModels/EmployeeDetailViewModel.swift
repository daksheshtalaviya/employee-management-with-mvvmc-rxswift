//
//  EmployeeDetailViewModel.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import Foundation
import RxSwift
import RxCocoa

class EmployeeDetailViewModel {
    private let companyDataManager: DatabaseManager
    let company: Company
    var employee: Employee

    let employeeName = BehaviorRelay<String>(value: "")
    let employeePosition = BehaviorRelay<String>(value: "")
    let employeeEmail = BehaviorRelay<String>(value: "")
    let isEmployeeResigned = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()

    init(companyDataManager: DatabaseManager, company: Company, employee: Employee) {
        self.companyDataManager = companyDataManager
        self.company = company
        self.employee = employee
        
    }
    
    func saveEmployee() {
        
        var employees = company.employees
        if !employees.contains(where: {$0 == employee}) {
            let newEmployee = Employee(id: Int(Date().timeIntervalSince1970),
                                       name: employeeName.value.trim,
                                       position: employeePosition.value.trim,
                                       email: employeeEmail.value.trim,
                                       isResigned: isEmployeeResigned.value)
            
            DKLog.log("newEmployee: \(newEmployee)")
            employees.append(newEmployee)
            company.employees = employees
        } else {
            DKLog.log("employee: \(employee)")
            
            employee.name = employeeName.value.trim
            employee.position = employeePosition.value.trim
            employee.isResigned = isEmployeeResigned.value
        }
        
        companyDataManager.saveCompanyData()
    }
}
