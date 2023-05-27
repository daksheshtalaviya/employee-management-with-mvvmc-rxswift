//
//  DatabaseManager.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import Foundation

class DatabaseManager {
    private let fileName = "companies.json"
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveDataToDirectory() {
        guard companies.isEmpty else { return }
        
        defer {
            if companies.isEmpty {
                companies = loadCompanyData() ?? []
            }
        }
        
        do {
            guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else { return }
            let data = try Data(contentsOf: fileURL)
            saveDataToFile(data)
        } catch {
            print("Failed to save data: \(error)")
        }
    }
    
    func saveCompanyData() {
        saveData(companies)
    }
    
    private func saveData<T: Codable>(_ model: T) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(model)
            saveDataToFile(data)
        } catch {
            print("Failed to save company data: \(error)")
        }
    }
    
    private func saveDataToFile(_ data: Data) {
        do {
            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
            DKLog.log("fileURL: \(fileURL.path)")
            
            try data.write(to: fileURL)
        } catch {
            print("Failed to save data: \(error)")
        }
    }
    
    
    private func loadCompanyData<T: Codable>() -> T? {
        do {
            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
            let data = try Data(contentsOf: fileURL)
            let company = try JSONDecoder().decode(T.self, from: data)
            return company
        } catch {
            print("Failed to load company data: \(error)")
            return nil
        }
    }
    
    lazy var companies: [Company] = { loadCompanyData() ?? [] }()
}
