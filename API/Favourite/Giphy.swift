//
//  Giphy.swift
//  Giphy
//  Created by Erkan Emir on 21.05.23.

import Foundation

struct Gif {
    let gifURL: String
    let gifID: String
    var isFavourite = false
    
    init(dictionary: [String : Any]) {
        self.gifURL = dictionary["gifURL"] as? String ?? ""
        self.gifID  = dictionary["gifID"]  as? String ?? ""
    }}

extension Gif: CommonData {
    var gifURL_     : String? { gifURL }
    var gifID_      : String? { gifID }
    var bannerURL   : String? { nil }
    var imageURL    : String? { nil }
    var userName    : String? { nil }
    var displayName_: String? { nil }

}
