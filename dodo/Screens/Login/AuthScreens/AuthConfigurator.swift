//
//  LoginCinfigurator.swift
//  dodo
//
//  Created by Юлия Ястребова on 06.10.2024.
//

import UIKit

final class AuthConfigurator {
    func configureLogin() -> LoginVC {
        let loginVC = LoginVC()
        let loginPresenter = AuthPresenter()
        
        loginVC.presenter = loginPresenter
        loginPresenter.loginView = loginVC
        
        return loginVC
    }
    
    func configurePhone() -> PhoneVC {
        let phoneVC = PhoneVC()
        let phonePresenter = AuthPresenter()
        
        
        phoneVC.presenter = phonePresenter
        phonePresenter.phoneView = phoneVC
        
        return phoneVC
    }
    
    func configureCode() -> CodeVC {
        let codeVC = CodeVC()
        let codePresenter = AuthPresenter()
        
        codeVC.presenter = codePresenter
        codePresenter.codeView = codeVC
        
        return codeVC
    }
}


