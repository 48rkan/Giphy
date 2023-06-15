//  LoginViewModel.swift
//  Giphy
//  Created by Erkan Emir on 14.05.23.

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

public struct LoginViewModel {
    let titleOne   = "Create an Account"
    let titleTwo   = "A GIPHY account lets you Favorite, Create,  & Collect all the GIFs!"
    let titleThree = "By logging in you agree to GIPHY's Terms of Service and Privacy Policy"
    
    var builder = LoginBuilder()
    
    var adapter: LoginAdapter?
    
    func register(credential:AuthCredential,type: LoginType,completion: @escaping (Error?)->()) {
        builder.setEmail(email: credential.email)
        builder.setPassword(password: credential.password)
        builder.setUsername(username: credential.username)
        adapter?.registerUser(credential: builder.build(), type: .email, completion: { error in
            completion(error)
        })
    }
    
    func login(credential:AuthCredential? = nil,type: LoginType,completion: @escaping (AuthDataResult?,Error?)->()) {
        if let credential = credential {
            builder.setEmail(email: credential.email)
            builder.setPassword(password: credential.password)
        }

        adapter?.loginUser(credential: builder.build(), type: type, completion: completion)
    }
    
//    func registerUser(credential:AuthCredential,
//                      completion: @escaping (Error?)->()) {
//        
//        builder.setEmail(email: credential.email)
//        builder.setPassword(password: credential.password)
//        builder.setUsername(username: credential.username)
//        
//        AuthService.registerUser(credential: builder.build()) { error in
//            completion(error)
//        }
//    }
    
//    public func logUserIn(email: String,password: String,
//                   completion: @escaping (AuthDataResult?,Error?)->()) {
//        AuthService.logUserIn(email: email, password: password) { data, error in
//            completion(data,error)
//        }
//    }
    
//    public func tappedGoggle(view: UIViewController,completion: @escaping ()->()) {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//    
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//
//        GIDSignIn.sharedInstance.signIn(withPresenting: view) { result, error in
//            if error != nil { return }
//            
//            guard let user    = result?.user else { return }
//            guard let idToken = user.idToken?.tokenString else { return }
//            
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
//            
//            AuthService.registerUser(credential: AuthCredential(email: user.fetcherAuthorizer.userEmail ?? "" , password: "***************", username: "User-\(Int.random(in: 1000...5000))")) { error in
//                if error != nil { print("\(error?.localizedDescription ?? "")")}
//                return
//            }
//            
//            Auth.auth().signIn(with: credential) { result, error in
//                if error != nil { return }
//                      
//                completion()
//            }
//        }
//    }
}


