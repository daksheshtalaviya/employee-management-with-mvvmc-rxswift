//
//  AppManager.swift
//  EmployeeManagement
//
//  Created by Dksh on 27/05/23.
//

import Foundation

class AppManager {
    static let shared: AppManager = AppManager()
    
    lazy var databaseManager = DatabaseManager()
    
    private init() {}
    
}
