//  CoreHelper.swift
//  Giphy
//  Created by Erkan Emir on 16.05.23.

import Foundation

public class CoreHelper {
    static let shared = CoreHelper()
    
    private let BASE_URL = "https://api.giphy.com/v1"
    private let API_KEY = "Q2iBbB8Ny4bNBxHKES4oqjKB5oltjOz4"
    
    public func url(path: String) -> String {
        return BASE_URL + path + "?api_key=\(API_KEY)"
    }
}
