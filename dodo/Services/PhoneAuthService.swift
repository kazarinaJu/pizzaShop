//
//  PhoneAuthService.swift
//  dodo
//
//  Created by Юлия Ястребова on 06.10.2024.
//

import UIKit
import FirebaseAuth

class PhoneAuthService {
    
    static let shared = PhoneAuthService()
    
    var currentVerificationId = ""
    
    private init() {}
    
    func requestOneTimePassword(for phoneNumber: String) {
        Auth.auth().languageCode = "ru"
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let verificationID = verificationID else { return }
            self.currentVerificationId = verificationID
        }
    }
    
    func signIn(with verificationCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: currentVerificationId, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }
    }
}
