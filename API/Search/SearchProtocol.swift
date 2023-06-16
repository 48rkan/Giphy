//
//  SearchProtocol.swift
//  Giphy
//  Created by Erkan Emir on 23.05.23.

import Foundation

protocol SearchProtocol {
    static func fetchMatchesGifs(text: String,
                                 type:HomeEndPoint,
                                 completion: @escaping (Trending?,Error?)->())
    
    static func fetchRelativeChannel(query: String,
                                     type: SearchEndPoint,
                                     completion: @escaping (RelativeChannel?,Error?)->())
}
