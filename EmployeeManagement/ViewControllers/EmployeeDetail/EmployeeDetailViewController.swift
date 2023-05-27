//
//  EmployeeDetailViewController.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import UIKit
import RxSwift
import RxCocoa

class EmployeeDetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resignationSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private var viewModel: EmployeeDetailViewModel!
    var coordinator: EmployeeCoordinator!

    var didTapBack: (()->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDetail()
        configureViewModel()
        bindViewModel()
    }
    
    private func configureViewModel() {
        viewModel = EmployeeDetailViewModel(companyDataManager: AppManager.shared.databaseManager, company: coordinator.company, employee: coordinator.employee)
    }
    
    private func bindViewModel() {
        
        // All text fields observer
        nameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.employeeName)
            .disposed(by: disposeBag)
        
        positionTextField.rx.text
            .orEmpty
            .bind(to: viewModel.employeePosition)
            .disposed(by: disposeBag)
        
        
        // Email text field observer
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.employeeEmail)
            .disposed(by: disposeBag)
        
        emailTextField.isUserInteractionEnabled = coordinator.employee.isNew
        
        let textFieldInteractionObserver = emailTextField.rx.controlProperty(editingEvents: .allEvents, getter: { $0.isUserInteractionEnabled }, setter: { $0.isUserInteractionEnabled = $1 })
        
        textFieldInteractionObserver
            .map { $0 ? 1.0 : 0.5 } // Set alpha to 1.0 when visible, 0.5 when hidden
            .bind(to: emailTextField.rx.alpha)
            .disposed(by: disposeBag)
        
        
        // Resignation Switch observer
        resignationSwitch.rx.isOn
            .bind(to: viewModel.isEmployeeResigned)
            .disposed(by: disposeBag)
        
        
        // View Model's Properties observer
        viewModel.employeeName
            .bind(to: nameTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.employeePosition
            .bind(to: positionTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.employeeEmail
            .bind(to: emailTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isEmployeeResigned
            .bind(to: resignationSwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.saveEmployee()
                self?.didTapBack?()
            })
            .disposed(by: disposeBag)
        
        
        // Create observables for the text of the three text fields
        let nameText = nameTextField.rx.text.orEmpty.asObservable()
        let positionText = positionTextField.rx.text.orEmpty.asObservable()
        let emailText = emailTextField.rx.text.orEmpty.asObservable()
        
        // Combine the three observables and check if all fields are not empty and contain valid email addresses
        let allFieldsValid = Observable.combineLatest(nameText, positionText, emailText)
            .map { !$0.trim.isEmpty && !$1.trim.isEmpty && !$2.trim.isEmpty && $2.isValidEmail }
        
        // Bind the button's visibility to the combined observable
        allFieldsValid
            .bind(to: saveButton.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
        
        allFieldsValid
            .map { $0 ? 1.0 : 0.5 } // Set alpha to 1.0 when visible, 0.5 when hidden
            .bind(to: saveButton.rx.alpha)
            .disposed(by: disposeBag)
    }
    
    private func setDetail() {
        
        title = coordinator.employee.isNew ? "Add New Employee" : "Update Employee Detail"

        nameTextField.text = coordinator.employee.name
        emailTextField.text = coordinator.employee.email
        positionTextField.text = coordinator.employee.position
        resignationSwitch.isOn = coordinator.employee.isResigned
    }
    
}
