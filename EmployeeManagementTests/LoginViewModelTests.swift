//
//  LoginViewModelTests.swift
//  EmployeeManagementTests
//
//  Created by Dksh on 27/05/23.
//

import XCTest
@testable import EmployeeManagement

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var databaseManager: EmployeeManagement.DatabaseManager!
    
    override func setUp() {
        super.setUp()
        
        let company = EmployeeManagement.Company(id: 1, name: "Acme Corp", employees: [])

        databaseManager = EmployeeManagement.DatabaseManager()
        viewModel = LoginViewModel(companyDataManager: databaseManager, company: company)
    }
    
    override func tearDown() {
        databaseManager = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testIsLoginEnabled_WithValidCompanyName() {
        // Given
        viewModel.companyName.accept("Acme Corp")
        
        // When
        let isLoginEnabled = viewModel.isLoginEnabled.values
        Task {
            do {
                for try await value in isLoginEnabled {
                    XCTAssertTrue(value == true)
                }
            } catch {
                print(error)
            }
        }
        
    }
    
    func testIsLoginEnabled_WithInvalidCompanyName() {
        // Given
        viewModel.companyName.accept("")
        
        // When
        let isLoginEnabled = viewModel.isLoginEnabled.values
        Task {
            do {
                for try await value in isLoginEnabled {
                    XCTAssertTrue(value == false)
                }
            } catch {
                print(error)
            }
        }
        
    }

    func testLogin_WithValidCompanyLoginCredential() {

        viewModel.companyName.accept("Acme Corp")

        let company = EmployeeManagement.Company(id: 1, name: "Acme Corp", employees: [])
        _ = viewModel.loginResult.subscribe(onNext: { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false)
            }
        })
        viewModel.login(company: company, password: "123456")
    }
    
    func testLogin_WithInValidCompanyLoginCredential() {

        viewModel.companyName.accept("Acme Corp")

        let company = EmployeeManagement.Company(id: 1, name: "Acme Corp", employees: [])
        _ = viewModel.loginResult.subscribe(onNext: { result in
            switch result {
            case .success:
                XCTAssertTrue(false)
            case .failure(_):
                XCTAssertTrue(true)
            }
        })
        viewModel.login(company: company, password: "")
    }
    
}
