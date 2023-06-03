//  AccountViewModel.swift
//  Giphy
//  Created by Erkan Emir on 17.05.23.

import Foundation

enum AccountType {
    case own,other
}

class AccountViewModel {
    var reusableData: CommonData?
    var otherProfileOwnerGifs  = [Datum]()
    var ownProfileFavouritedGifs = [Gif]()
    var ownAccountData: CommonData?
    var type: AccountType

    var successCallBack: (()->())?
    
    var bannerURL      : URL?   { URL(string: reusableData?.bannerURL ?? "")}
    var profileImageURL: URL?   { URL(string: reusableData?.imageURL ?? "")}
    var userName       : String { reusableData?.userName ?? "" }
    var displaName     : String { reusableData?.displayName_ ?? ""}
    
    init(items: CommonData?, type: AccountType) {
        self.reusableData = items
        self.type = type
    }
    
    func getProfile() {
        if type == .own {
            fetchOwnAccountData()
        } else {
            fetchOtherProfileOwnerGifs()
        }
    }
    
    func fetchOtherProfileOwnerGifs() {
        guard let username = reusableData?.userName else { return }
        
        HomeManager.fetchRelatedGifs(query: "@\(username)") { items, error in
            if error != nil { return }
            
            guard let items = items?.data else { return }
            self.otherProfileOwnerGifs = items
            
            self.successCallBack?()
        }
    }
    
    func fetchOwnProfileFavouritedGifs() {
        FavouriteManager.fetchFavouritesGifs { gifs in
            self.ownProfileFavouritedGifs = gifs
            self.successCallBack?()
        }
    }
    
    func fetchOwnAccountData() {
        UserService.fetchUser { account in
            self.reusableData = account
            self.fetchOwnProfileFavouritedGifs()
        }
    }
}
