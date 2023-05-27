//
//  LoginViewController.swift
//  EmployeeManagement
//
//  Created by Dksh on 26/05/23.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private var viewModel: LoginViewModel!
    var coordinator: LoginCoordinator!

    var didTapBack: (()->Void)?

    deinit {
        DKLog.log()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DKLog.log("company: \(coordinator.company.name)")

        configureViewModel()
        bindViewModel()
    }
    
    private func configureViewModel() {
        viewModel = LoginViewModel(companyDataManager: AppManager.shared.databaseManager, company: coordinator.company)
        
        companyNameLabel.text = coordinator.company.name
    }
    
    private func bindViewModel() {

        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.companyName)
            .disposed(by: disposeBag)
        
        viewModel.isLoginEnabled
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.viewModel.login(company: self.viewModel.company, password: self.passwordTextField.text)
            })
            .disposed(by: disposeBag)
        
        viewModel.loginResult
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    self.coordinator.showDetail(self.coordinator.company)
                    break
                case .failure(let error):
                    self.showAlert(with: "Error", message: error.localizedDescription)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    private func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
   
}
