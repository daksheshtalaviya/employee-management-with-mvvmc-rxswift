//
//  CompanyListViewModel.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import Foundation
import RxSwift
import RxCocoa

class CompanyListViewModel {
    
    private let companyDataManager: DatabaseManager
    private let disposeBag = DisposeBag()
    
    let companies: BehaviorRelay<[Company]> = BehaviorRelay(value: [])
    
    init(companyDataManager: DatabaseManager) {
        self.companyDataManager = companyDataManager
        
        companies.accept(companyDataManager.companies)        
    }
    
    func company(at index: Int) -> Company? {
        return companies.value[safe: index]
    }
    
}


