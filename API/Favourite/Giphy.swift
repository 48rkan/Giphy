//
//  Giphy.swift
//  Giphy
//
//  Created by Erkan Emir on 21.05.23.
//

import Foundation

struct Gif {
    let gifURL: String
    let gifID: String
    var isFavourite = false
    
    init(dictionary: [String : Any]) {
        self.gifURL = dictionary["gifURL"] as? String ?? ""
        self.gifID = dictionary["gifID"] as? String ?? ""

    }}
