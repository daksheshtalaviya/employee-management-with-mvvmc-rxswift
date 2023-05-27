//
//  EmployeeListViewModelTests.swift
//  EmployeeManagementTests
//
//  Created by Dksh on 27/05/23.
//

import XCTest
import RxSwift
@testable import EmployeeManagement

class EmployeeListViewModelTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    var viewModel: EmployeeListViewModel!
    
    override func setUp() {
        super.setUp()
        
        disposeBag = DisposeBag()
        
        // Create a sample company and view model
        let company = EmployeeManagement.Company(id: 1, name: "Example Company", employees: [])
        viewModel = EmployeeListViewModel(companyDataManager: EmployeeManagement.DatabaseManager(), company: company)
    }
    
    func testAddEmployee() {
        // Given
        let employeeToAdd = EmployeeManagement.Employee(id: 1, name: "John Doe", position: "Manager", isResigned: false)
        let expectedEmployees = [employeeToAdd]
        
        var capturedEmployees: [EmployeeManagement.Employee] = []
        viewModel.employees
            .subscribe(onNext: { employees in
                capturedEmployees = employees
            })
            .disposed(by: disposeBag)
        
        // When
        viewModel.addEmployee(employeeToAdd)
        
        // Then
        XCTAssertEqual(capturedEmployees, expectedEmployees)
    }


}

