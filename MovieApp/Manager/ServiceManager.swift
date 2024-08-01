//
//  ServiceManager.swift
//  MovieApp
//
//  Created by Nevin Özkan on 31.07.2024.
//

import Foundation
import Alamofire

private let apiKey = "1ae0a7f53c245e3bc03196612d1e663a"
private let baseURL = "https://api.themoviedb.org/3/movie/upcoming"
    
final class ServiceManager {
    
    func fetchUpcomingMovies(completion: @escaping (Result<Data, AFError>) -> Void) {
        let parameters: [String: String] = [
            "language": "en-US",
            "page": "1"
        ]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        AF.request(baseURL, parameters: parameters, headers: headers)
            .validate() 
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print("Network error: \(error)")
                    completion(.failure(error))
                }
            }
    }
}
