//  ImageUploader.swift
//  Giphy
//  Created by Erkan Emir on 22.05.23.

import FirebaseStorage
import UIKit
import FirebaseAuth
import FirebaseFirestore

struct ImageUploader {
    static func uploadImage(image: UIImage,
                            completion: @escaping (String) -> ()) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let fileName = NSUUID().uuidString
        
        //burada referans yaradiriq bir nov bos bir referans
        let ref = Storage.storage().reference(withPath: "/profile/images/\(fileName)")
        
        // burada ise hemin bos referansa data qoyuruq
        ref.putData(imageData) {  metaData, error in
            if error != nil {
                print("Error : \(error?.localizedDescription ?? "" )")
                return
            }

            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString  else { return  }
                completion(imageUrl)
            }
        }
    }
    
    static func changePhoto(image: UIImage) {
        ImageUploader.uploadImage(image: image) { imageUrl in
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            Firestore.firestore().collection("user").document(uid).updateData(["gif" : imageUrl])
        }
    }
}
