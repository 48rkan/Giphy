//
//  SearchProtocol.swift
//  Giphy
//  Created by Erkan Emir on 23.05.23.

import Foundation

protocol SearchProtocol {
    static func fetchMatchesGifs(text: String,completion: @escaping (Trending?,Error?)->())
    
    static func fetchRelativeChannel(query: String,completion: @escaping (RelativeChannel?,Error?)->())
}
