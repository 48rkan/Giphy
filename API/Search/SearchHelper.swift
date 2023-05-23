//
//  SearchHelper.swift
//  Giphy
//  Created by Erkan Emir on 23.05.23.

import Foundation

//enum SearchType: String {
//    case relativeChannels = "RelativeChannels"
//}

enum SearchEndPoint: String {
case relativeChannels = "/channels/search"
    
    public func path() -> String { return CoreHelper.shared.url(path: self.rawValue) }}
