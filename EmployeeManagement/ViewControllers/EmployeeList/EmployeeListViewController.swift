//
//  EmployeeListViewController.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var viewModel: EmployeeListViewModel!
    var coordinator: EmployeeListCoordinator!
    
    var didTapBack: (()->Void)?

    // Configure the data source using RxTableViewSectionedReloadDataSource
    let dataSource = RxTableViewSectionedReloadDataSource<EmployeeSection>(
        configureCell: { dataSource, tableView, indexPath, employee in
            var cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell")
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "EmployeeCell")
            }
            cell?.textLabel?.text = employee.name
            cell?.detailTextLabel?.text = employee.position
            cell?.accessoryType = employee.isResigned ? .checkmark : .none
            return cell!
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].header
        }
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = coordinator.company.name
        
        configureViewModel()
        bindViewModel()
        configureTableView()
        addNavigationButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadEmployees()
    }
    
    private func addNavigationButtons() {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        addButton.rx.tap.subscribe { [weak self] _ in
            self?.coordinator.showDetail(Employee(id: 0, name: "", position: "", isResigned: false, isNew: true))
        }
        .disposed(by: disposeBag)
        self.navigationItem.setRightBarButtonItems([addButton], animated: true)
    }
    
    private func configureViewModel() {
        viewModel = EmployeeListViewModel(companyDataManager: AppManager.shared.databaseManager, company: coordinator.company)
    }
    
    private func loadData() {
        
        // Bind the data to the table view using RxSwift
        viewModel.employees
            .map { [EmployeeSection(items: $0, header: "Employees")] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        
        loadData()
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let employee = self?.viewModel.employee(at: indexPath.row) else { return }
                self?.coordinator.showDetail(employee)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
    }
    
}
