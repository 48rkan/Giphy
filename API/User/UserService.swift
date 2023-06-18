//  UserService.swift
//  Giphy
//  Created by Erkan Emir on 21.05.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct UserService {
    static func fetchUser(completion: @escaping (Account)->()) {
        var id = ""
        
        if UserDefaults.standard.bool(forKey: "GOOGLE_SIGN_UP") == true {
            let email = UserDefaults.standard.string(forKey: "GOOGLE_EMAIL")
            id = email ?? ""
        } else {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            id = uid
        }
        
        COLLECTION_USER.document(id).getDocument { documentSnapshot, error in
            guard let dictionary = documentSnapshot?.data() else { return }
            
            completion(Account(dictionary: dictionary))
        }
    }
    
    static func updateUserName(newUsername: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USER.document(uid).updateData(["username" : newUsername])
    }
}
