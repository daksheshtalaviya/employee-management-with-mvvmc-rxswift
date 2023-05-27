//
//  CompanySection.swift
//  EmployeeManagement
//
//  Created by Dksh on 27/05/23.
//

import RxDataSources

struct CompanySection {
    var items: [Company]
    var header: String
}

extension CompanySection: SectionModelType {
    typealias Item = Company

    init(original: CompanySection, items: [Company]) {
        self = original
        self.items = items
    }
}
