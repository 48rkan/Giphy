//
//  SwiftyGif+ ext.swift
//  Giphy
//  Created by Erkan Emir on 03.06.23.

import Foundation
import SwiftyGif

extension CVarArg {
    func setGifFromURL(imageView: UIImageView,
                       url: URL) {
        imageView.setGifFromURL(url,
                                levelOfIntegrity: .superLowForSlideShow,
                                showLoader: true)
    }
}
