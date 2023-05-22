//  UserService.swift
//  Giphy
//  Created by Erkan Emir on 21.05.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct UserService {
    static func fetchUser(completion: @escaping (Account)->()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("user")
            .document(uid)
            .getDocument { documentSnapshot, error in
            
            guard let dictionary = documentSnapshot?.data() else { return }
            
            completion(Account(dictionary: dictionary))
        }
    }
    
    static func updateUserName(newUsername: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("user")
            .document(uid)
            .updateData(["username" : newUsername])
    }
}
