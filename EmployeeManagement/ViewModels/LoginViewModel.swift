//
//  LoginViewModel.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let companyName = BehaviorRelay<String>(value: "")
    var isLoginEnabled: Observable<Bool>
    let isCompanyNameValid: Observable<Bool>

    private let companyDataManager: DatabaseManager
    let company: Company

    private let _loginResult = PublishSubject<Result<Void, Error>>()
    var loginResult: Observable<Result<Void, Error>> {
        return _loginResult.asObservable()
    }
    
    init(companyDataManager: DatabaseManager, company: Company) {
        self.companyDataManager = companyDataManager
        self.company = company
        
        isCompanyNameValid = companyName
            .map { !$0.isEmpty }
            .distinctUntilChanged()
        
        isLoginEnabled = Observable.combineLatest(companyName, isCompanyNameValid)
            .map { companyName, isCompanyNameValid in
                return !companyName.isEmpty && isCompanyNameValid
            }
    }
    
    func login(company: Company, password: String?) {
        DKLog.log("\(company.id) : \(company.name), password: \(password ?? "")")

        // TODO: Verify password here
        let success = password == "123456"
        if success {
            _loginResult.onNext(.success(()))
        } else {
            let error = NSError(domain: "LoginError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Login failed"])
            _loginResult.onNext(.failure(error))
        }
    }
}
