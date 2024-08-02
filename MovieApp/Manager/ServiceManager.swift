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
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYWUwYTdmNTNjMjQ1ZTNiYzAzMTk2NjEyZDFlNjYzYSIsIm5iZiI6MTcyMjQyNzk0OS40NDQwNjYsInN1YiI6IjY1YzhhNDllYWFkOWMyMDE3ZGI4MmVjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kX2vPm9mau3UH-XQN1LF3PuQBld6PIf4OMyuRfd1AjA"
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
