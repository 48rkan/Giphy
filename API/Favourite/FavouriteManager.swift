//  FavouriteManager.swift
//  Giphy
//  Created by Erkan Emir on 21.05.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FavouriteManager {
    static func favouriteGif(gifID: String,gifURL: String) {
        
        let data: [String:Any] = [
            "gifURL": gifURL,
            "gifID" : gifID
        ]
        
        COLLECTION_FAVOURITE
            .document(gifID)
            .setData(data)
    }
    
    static func unFavouriteGif(gifID: String) {

        COLLECTION_FAVOURITE
            .document(gifID)
            .delete()
    }
    
    static func fetchFavouritesGifs(completion: @escaping ([Gif])->()) {
        COLLECTION_FAVOURITE
            .getDocuments { querySnapshot, error in
                
            guard let documents = querySnapshot?.documents else { return }
            
            let datas = documents.map { queryDocumentSnapshot in
                let dictionary = queryDocumentSnapshot.data()
                
                return Gif(dictionary: dictionary)
            }
            completion(datas)
        }
    }
    
    static func checkFavourite(id: String , completion : @escaping (Bool)->()) {
                
        COLLECTION_FAVOURITE
            .document(id)
            .getDocument { documentSnapshot, error in
            guard let isFollowed = documentSnapshot?.exists else { return }
            
            completion(isFollowed)
        }
    }
}
