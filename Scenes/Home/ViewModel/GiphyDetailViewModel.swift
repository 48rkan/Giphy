//  GiphyDetailViewModel.swift
//  Giphy
//  Created by Erkan Emir on 17.05.23.

import Foundation

class GiphyDetailViewModel {
    
    let items: CommonData
    var relatedItems = [CommonData]()
    
    var succesCallBack: (()->())?
    
    init(items: CommonData) {
        self.items = items
    }
    
    var gifURL: URL? { URL(string: items.gifURL ?? "" ) }
    
    var userNamePhotoURL: URL? { URL(string: items.imageURL ?? "")}
    
    var userNameText: String { items.userName ?? ""}
    
    var displayNameText: String { items.displayName_ ?? ""}

    
    func fetchRelatedGifs() {
        GiphyDetailManager.fetchRelatedGifs(query: items.userName ?? "") { items, error in
            if error != nil { return }
            
            guard let items = items?.data else { return }
            self.relatedItems = items
            
            self.succesCallBack?()
        }
    }
}
