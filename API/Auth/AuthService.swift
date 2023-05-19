//  LoginService.swift
//  Giphy
//  Created by Erkan Emir on 13.05.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct AuthService {
    
    static func logUserIn(email: String,password: String,completion: @escaping (AuthDataResult?,Error?) ->()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            completion(authDataResult,error)
        }
    }
    
    static func registerUser(credential: AuthCredential, completion: @escaping (Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: credential.email, password: credential.password) { result, error in
            if error != nil {
                completion(error)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let data: [String:Any] = [
                "email": credential.email,
                "password": credential.password,
                "username": credential.username.lowercased(),
                "uid": uid
            ]
    
            Firestore.firestore().collection("user").document(uid).setData(data,completion: completion)
        }
    }
}
