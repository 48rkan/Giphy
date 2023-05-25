//  GiphyDetailViewModel.swift
//  Giphy
//  Created by Erkan Emir on 17.05.23.

import UIKit

class GiphyDetailViewModel {

    let items: CommonData
    var relatedItems = [CommonData]()
    var succesCallBack: (()->())?
    var isFavourite = false
    
    var controller: UIViewController?
    init(items: CommonData) {
        self.items = items
    }
    
    var userNameText: String    { items.userName ?? ""}
    var displayNameText: String { items.displayName_ ?? ""}
    var userNamePhotoURL: URL?  { URL(string: items.imageURL ?? "")}
    var gifURL: URL?            { URL(string: items.gifURL_ ?? "" )}
    
    func fetchRelatedGifs() {
        HomeManager.fetchRelatedGifs(query: items.userName ?? "") { items, error in
            if error != nil { return }
            
            guard let items = items?.data else { return }
            self.relatedItems = items
            
            self.succesCallBack?()
            
        }
    }

    func checkGifsIfFavourite(completion: @escaping ((Bool)->()))  {
        FavouriteManager.checkFavourite(id: items.gifID_ ?? "") { isFavourite in
            self.isFavourite = isFavourite
            completion(isFavourite)
        }
    }
    
    func alert(title: String,completion: (UIAlertController)->()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: title,
                                      style: .default,
                                      handler: { _ in
        }))

        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .default,
                                      handler: nil))

        completion(alert)
    }
}
