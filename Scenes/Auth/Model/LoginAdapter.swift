//
//  AuthAdapter.swift
//  Giphy
//  Created by Erkan Emir on 14.06.23.

import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore

enum LoginType {
    case email
    case google
}

//adapter - controller,viewModel'i musteqillesirimeye xidmet edir.Controllerde viewmodelde bir deyisiklik oldugu teqdirde her yerde deyismeliyik.Amma bele

class LoginAdapter {

    var controller: LoginController
    
    init(controller: LoginController) {
        self.controller = controller
    }
    
    func registerUser(credential:AuthCredential,
                      type: LoginType,
                      completion: @escaping (Error?)->()) {
        switch type {
        case .email : registerWithEmail(credential: credential, completion: completion)
        case .google: return
        }
    }
    
    func loginUser(credential:AuthCredential? = nil,
                   type: LoginType,
                   completion: @escaping (AuthDataResult?, Error?)->() ) {
        switch type {
        case .email  : loginWithEmail(email: credential!.email,password: credential!.password,
                                      completion: completion)
        case .google : loginWithGoogle(view: controller, completion: completion)
        }
    }
    
    private func registerWithEmail(credential:AuthCredential,
                                   completion: @escaping (Error?)->()) {
        AuthService.registerUserWithEmail(credential: credential) { error in
            completion(error)
        }
    }
    
    private func loginWithGoogle(view: UIViewController,completion: @escaping (AuthDataResult?, Error?)->()) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { result, error in
            if error != nil { return }
            
            guard let user    = result?.user              else { return }
            guard let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString)
            
            AuthService.registerUserWithGoogle(credential: .init(
                email: user.profile?.email ?? "",
                password: "***",
                username: "User-\(Int.random(in: 1000...5000))")) { error in
                    if error != nil { print("\(error?.localizedDescription ?? "")")}
                    return
                }
            
//            AuthService.registerUserWithEmail(credential: AuthCredential(
//                email: user.fetcherAuthorizer.userEmail ?? "" ,
//                password: "***",
//                username: "User-\(Int.random(in: 1000...5000))")) { error in
//                    if error != nil { print("\(error?.localizedDescription ?? "")")}
//                    return
//                }
            
            Auth.auth().signIn(with: credential) { result, error in
                if error != nil { return }
                
                completion(result,error)
            }
        }
    }
    
    private func loginWithEmail(email: String,password: String,
                                completion: @escaping (AuthDataResult?,Error?)->()) {
        AuthService.logUserIn(email: email, password: password) { data, error in
            completion(data,error)
        }
    }
}
