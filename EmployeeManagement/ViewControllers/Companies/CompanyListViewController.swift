//
//  CompanyListViewController.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CompanyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var viewModel: CompanyListViewModel!
    var coordinator: CompanyCoordinator!
   

    var didTapBack: (()->Void)?
    
    // Configure the data source using RxTableViewSectionedReloadDataSource
    let dataSource = RxTableViewSectionedReloadDataSource<CompanySection>(
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath)
            cell.textLabel?.text = item.name
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].header
        }
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        configureViewModel()
        bindViewModel()
        configureTableView()
    }
    
    private func configureViewModel() {
        viewModel = CompanyListViewModel(companyDataManager: AppManager.shared.databaseManager)
    }
    
    private func bindViewModel() {
       
        let sections = [
            CompanySection(items: viewModel.companies.value, header: "Companies")
        ]

        // Bind the data to the table view using RxSwift
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self else { return }
                guard let company = self.viewModel.company(at: indexPath.row) else { return }
                self.coordinator.showDetail(company)                
            })
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CompanyCell")
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
}
