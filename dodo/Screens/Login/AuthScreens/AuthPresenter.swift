//
//  LoginPresenter.swift
//  dodo
//
//  Created by Юлия Ястребова on 06.10.2024.
//

import UIKit

protocol AuthPresenterProtocol: AnyObject {
    var phoneView: PhoneVCProtocol? { get set }
    var codeView: CodeVCProtocol? { get set }
    
    func getCodeButtonTapped()
    func getEnterButtonTapped()
   
}

final class AuthPresenter: AuthPresenterProtocol {
    var loginView: LoginVCProtocol?
    var phoneView: PhoneVCProtocol?
    var codeView: CodeVCProtocol?
    
    let phoneAuthViewService = PhoneAuthService.shared
    
    func getCodeButtonTapped() {

        guard let phoneNumber = phoneView?.phoneTextField.text else {
            print("phoneView или phoneNumber пустой")
            return
        }
        phoneAuthViewService.requestOneTimePassword(for: phoneNumber)
        phoneView?.navigateToCodeScreen()
    }
    
    func getEnterButtonTapped() {
        
        guard let verificationCode = codeView?.codeTextField.text, !verificationCode.isEmpty else {
            print("Надо ввести код")
            return
        }
        
        phoneAuthViewService.signIn(with: verificationCode) { [weak self] result in
                switch result {
                case .success:
                    self?.codeView?.navigateToProfile()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
  
}
