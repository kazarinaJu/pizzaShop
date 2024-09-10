//
//  ServerConfig.swift
//  dodo
//
//  Created by Юлия Ястребова on 04.09.2024.
//

import Foundation

enum BaseURL: String {
    case QA = "https://test.com"
    case PROD = "https://prod.com"
    case LOCAL = "https://local.com"
}

class ServerConfig {
    static let shared: ServerConfig = ServerConfig()
    
    var baseURL: String?
    
    func setUpServerConfig() {
        #if LOCAL
        self.baseURL = BaseURL.LOCAL.rawValue
        #elseif QA
        self.baseURL = BaseURL.QA.rawValue
        #elseif PROD
        self.baseURL = BaseURL.PROD.rawValue
        #endif
    }
}
