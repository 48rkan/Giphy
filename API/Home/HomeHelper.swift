//  HomeHelper.swift
//  Giphy
//  Created by Erkan Emir on 16.05.23.

import Foundation

enum GifsType: String {
    case trending    = "Trending"
    case stickers    = "Stickers"
    case emoji       = "Emoji"
    case cats        = "Cats"
    case dogs        = "Dogs"
    case memes       = "Memes"
    case reactions   = "Reactions"
    case none
}

public enum HomeEndPoint: String {
    case trending    = "/gifs/trending"
    case stickers    = "/stickers/trending"
    case emoji       = "/emoji"
    case common      = "/gifs/search"
    
    public func path() -> String { CoreHelper.shared.url(path: self.rawValue) }
}
