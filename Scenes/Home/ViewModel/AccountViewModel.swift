//  AccountViewModel.swift
//  Giphy
//  Created by Erkan Emir on 17.05.23.

import Foundation

class AccountViewModel {
    var items: CommonData
    
    var ownerGifs = [Datum]()
    
    var successCallBack: (()->())?
    
    init(items: CommonData) {
        self.items = items
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

}
