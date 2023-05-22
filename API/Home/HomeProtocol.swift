//
//  HomeProtocol.swift
//  Giphy
//  Created by Erkan Emir on 23.05.23.

import Foundation

protocol HomeManagerProtocol {
    static func fetchGifs(limit: Int,
                          type: GifsType,
                          query: String,
                          completion: @escaping (Trending?,Error?)->())
    
    static func fetchRelatedGifs(query: String,
                                 completion: @escaping (Trending?,Error?)->())
}
