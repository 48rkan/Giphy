//  LoginViewModel.swift
//  Giphy
//  Created by Erkan Emir on 14.05.23.

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

struct LoginViewModel {
    
    let titleOne = "Create an Account"
    
    let titleTwo = "A GIPHY account lets you Favorite, Create,  & Collect all the GIFs!"
    
    let titleThree = "By logging in you agree to GIPHY's Terms of Service and Privacy Policy"
    
    func registerUser(credential:AuthCredential,
                      completion: @escaping (Error?)->()) {
        let credential = AuthCredential(email: credential.email,
                                        password: credential.password,
                                        username: credential.username)
        
        AuthService.registerUser(credential: credential) { error in
            completion(error)
        }
    }
    
    func logUserIn(email: String,password: String,
                   completion: @escaping (AuthDataResult?,Error?)->()) {
        AuthService.logUserIn(email: email, password: password) { data, error in
            completion(data,error)
        }
    }
    
    func tappedGoggle(view: UIViewController,completion: @escaping ()->()) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: view) { result, error in
            if error != nil { return }
            
            guard let user    = result?.user else { return }
            guard let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            AuthService.registerUser(credential: AuthCredential(email: user.fetcherAuthorizer.userEmail ?? "" , password: "***************", username: "User-\(Int.random(in: 1000...5000))")) { error in
                if error != nil { print("\(error?.localizedDescription)")}
                return
            }
            
            Auth.auth().signIn(with: credential) { result, error in
                if error != nil { return }
                      
                completion()
            }
        }
    }
}
