//  AccountViewModel.swift
//  Giphy
//  Created by Erkan Emir on 17.05.23.

import Foundation

enum AccountType {
    case own
    case other
}

class AccountViewModel {
    var items: CommonData
    var ownerGifs = [Datum]()
    var favouritedGifs = [Gif]()
    
    var successCallBack: (()->())?
    
    var type: AccountType
    
    init(items: CommonData,type: AccountType) {
        self.items = items
        self.type = type
    }
        
    var bannerURL: URL? { URL(string: items.bannerURL ?? "")}
    var profileImageURL: URL? { URL(string: items.imageURL ?? "")}
    var userName: String { items.userName ?? ""}
    var displaName: String { items.displayName_ ?? ""}

    func fetchOwnerGifs() {
        guard let username = items.userName else { return }
        
        GiphyDetailManager.fetchRelatedGifs(query: "@\(username)") { items, error in
            if error != nil { return }
            
            guard let items = items?.data else { return }
            self.ownerGifs = items
            
            self.successCallBack?()
        }
    }
    
    func fetchFavouritedGifs() {
        FavouriteManager.fetchFavouritesGifs { gifs in
            self.favouritedGifs = gifs
            self.successCallBack?()
        }
    }
}
