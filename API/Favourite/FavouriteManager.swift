//  FavouriteManager.swift
//  Giphy
//  Created by Erkan Emir on 21.05.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FavouriteManager {
    static func favouriteGif(gifID: String,gifURL: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let dataRef = COLLECTION_FAVOURITE.document(uid).collection("giphy-favourite").document()

        let data: [String:Any] = [
            "gifURL": gifURL,
            "gifID" : gifID,
            "documentID": dataRef.documentID
        ]
                
        COLLECTION_FAVOURITE.document(uid).collection("giphy-favourite").document(gifID).setData(data)
    }
    
    static func unFavouriteGif(gifID: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FAVOURITE.document(uid).collection("giphy-favourite").document(gifID).delete()
    }
    
    static func fetchFavouritesGifs(completion: @escaping ([Gif])->()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        COLLECTION_FAVOURITE.document(uid).collection("giphy-favourite").getDocuments { querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else { return }
            
            let datas = documents.map { queryDocumentSnapshot in
                let dictionary = queryDocumentSnapshot.data()
                
                return Gif(dictionary: dictionary)
            }
            completion(datas)
        }
    }
    
    static func checkFavourite(id: String , completion : @escaping (Bool)->()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        COLLECTION_FAVOURITE.document(uid).collection("giphy-favourite").document(id)
//        COLLECTION_FAVOURITE.document(id)
            .getDocument { documentSnapshot, error in
            guard let isFollowed = documentSnapshot?.exists else { return }
            
            completion(isFollowed)
        }
    }
}
