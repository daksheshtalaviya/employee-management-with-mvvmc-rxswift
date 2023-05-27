//
//  EmployeeSection.swift
//  EmployeeManagement
//
//  Created by Dksh on 27/05/23.
//

import RxDataSources

struct EmployeeSection {
    var items: [Employee]
    var header: String
}

extension EmployeeSection: SectionModelType {
    typealias Item = Employee

    init(original: EmployeeSection, items: [Employee]) {
        self = original
        self.items = items
    }
}
