//  Constant.swift
//  Giphy
//  Created by Erkan Emir on 23.05.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

let COLLECTION_FAVOURITE = Firestore.firestore().collection("favourite")
let COLLECTION_USER      = Firestore.firestore().collection("user")
