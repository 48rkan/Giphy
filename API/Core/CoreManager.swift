//  CoreManager.swift
//  Giphy
//  Created by Erkan Emir on 16.05.23.

import Foundation
import Alamofire

public class CoreManager {
        
    static func request<T: Codable>(type: T.Type,
                        url: String,
                        method: HTTPMethod = .get,
                        parameters: Parameters? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: HTTPHeaders? = nil,
                        completion: @escaping (T?,Error?)->()) {
        
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "",
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers).responseDecodable(of: T.self) { object in
            switch object.result {
            case .success(let items):
                completion(items,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
}
