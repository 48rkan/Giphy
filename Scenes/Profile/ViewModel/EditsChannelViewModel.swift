//
//  EditsChannelViewModel.swift
//  Giphy
//
//  Created by Erkan Emir on 22.05.23.
//

import Foundation
import YPImagePicker

class EditsChannelViewModel {
    var items: CommonData
    
    init(items: CommonData) {
        self.items = items
    }
    
    var gifURL: URL? { URL(string: items.gifURL_ ?? "")}
    
    var userName: String { items.userName ?? ""}
    
    func imagePickerConfiguration(completion: (YPImagePicker)->()) {
        // Burda konfiqurasiya veririk,pickerimiz ucun.Hansi formada acilsin,nece olsun kimi
        var config =  YPImagePickerConfiguration()
        config.library.mediaType = .photo
        // shouldSaveNewPicturesToAlbum - sekilleri qaleraya kayd elesin ya yox demekdir,paylasdiginiz.
        config.shouldSaveNewPicturesToAlbum = false
        config.startOnScreen = .library
        config.screens = [.library]
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        // maxNumberOfItems - nece dene sekil sece bilerler onu bildirir
        config.library.maxNumberOfItems = 1
        
        // ImagePicker - goruntuleri toplayan demekdir.
        let picker = YPImagePicker(configuration: config)
        
        completion(picker)
//        present(picker, animated: true)
        
//        didFinishPickingMedia(picker: picker)
    }
    
//    func didFinishPickingMedia(picker: YPImagePicker) {
//        picker.didFinishPicking { items, cancelled in
//            self.dismiss(animated: false) {
//                // secdiyimiz tek sekile bele catiriq
//                guard let image = items.singlePhoto?.image else { return }
//                
//            }
//        }
//    }
}
