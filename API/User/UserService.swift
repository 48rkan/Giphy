//
//  UserService.swift
//  Giphy
//
//  Created by Erkan Emir on 21.05.23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct UserService {
    static func fetchUser(completion: @escaping (Account)->()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("user").document(uid).getDocument { documentSnapshot, error in
            
            guard let dictionary = documentSnapshot?.data() else { return }
            
            guard let email = dictionary["email"] as? String else { return }
            guard let gif   = dictionary["gif"] as? String else { return }
            guard let username = dictionary["username"] as? String else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            guard let banner = dictionary["banner"] as? String else { return }

            
            completion(Account(email: email, username: username, profilimage: gif, uid: uid, banner: banner))
        }
    }
}
