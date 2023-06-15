//  AuthCredential.swift
//  Giphy
//  Created by Erkan Emir on 13.05.23.

import Foundation

struct AuthCredential {
    var email   : String
    var password: String
    var username: String
}

class LoginBuilder {
    private var email    = ""
    private var password = ""
    private var username = ""
    
    func setEmail(email: String) {
        self.email = email
    }
    
    func setPassword(password: String) {
        self.password = password
    }
        
    func setUsername(username: String) {
        self.username = username
    }

    func getEmail()    -> String { email    }
    func getPassword() -> String { password }
    func getUsername() -> String { username }
    
    func build() -> AuthCredential {
        .init(email: email, password: password, username: username)
    }
    
    func clear() {
        email    = ""
        password = ""
        username = ""
    }
}

