//  LoginService.swift
//  Giphy
//  Created by Erkan Emir on 13.05.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct AuthService {
    static func logUserIn(email: String,password: String,
                          completion: @escaping (AuthDataResult?,Error?) ->()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            completion(authDataResult,error)
        }
    }
    
    static func registerUser(credential: AuthCredential,
                             completion: @escaping (Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: credential.email, password: credential.password) { result, error in
            if error != nil {
                completion(error)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let defaultPhotoGif = "https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExNjQ2Yzg5YzcxNTRhM2FhNjYzMjg2ZWE0ZmZlMGZkZmFlNGM4YTBjZSZlcD12MV9pbnRlcm5hbF9naWZzX2dpZklkJmN0PWc/Fc0krhDnpoMw2TWYoz/giphy.gif"
            
            let data: [String:Any] = [
                "email": credential.email,
                "username": credential.username.lowercased(),
                "uid": uid,
                "gif" : defaultPhotoGif,
                "banner": defaultPhotoGif
            ]
    
            COLLECTION_USER
                .document(uid)
                .setData(data,completion: completion)
        }
    }
}
