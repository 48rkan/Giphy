//  SearchHelper.swift
//  Giphy
//  Created by Erkan Emir on 23.05.23.

import Foundation

enum SearchEndPoint: String {
    case relativeChannels = "/channels/search"
    
    public func path() -> String { CoreHelper.shared.url(path: self.rawValue) }
}
