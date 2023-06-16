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
    
    static func registerUserWithEmail(credential: AuthCredential,
                             completion: @escaping (Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: credential.email,
                               password: credential.password) { result, error in
            if error != nil {
                completion(error)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let data: [String:Any] = [
                "email"   : credential.email,
                "username": credential.username.lowercased(),
                "uid"     : uid,
                "gif"     : AuthHelper.defaultPhotoGif,
                "banner"  : AuthHelper.bannerGif
            ]
            
            COLLECTION_USER.document(uid)
                .setData(data,completion: completion)
            
            UserDefaults.standard.set(false, forKey: "GOOGLE_SIGN_UP")
            

        }
    }
    
    static func registerUserWithGoogle(credential: AuthCredential,
                                       completion: @escaping (Error?) -> ()) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
                
        let data: [String:Any] = [
            "email"   : credential.email,
            "username": credential.username.lowercased(),
            "uid"     : credential.email,
            "gif"     : AuthHelper.defaultPhotoGif,
            "banner"  : AuthHelper.bannerGif
        ]
        
        COLLECTION_USER.document(credential.email)
            .setData(data,completion: completion)
        
        UserDefaults.standard.set(true, forKey: "GOOGLE_SIGN_UP")
        UserDefaults.standard.set(credential.email, forKey: "GOOGLE_EMAIL")

    }
}
