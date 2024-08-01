//
//  MainVM.swift
//  MovieApp
//
//  Created by Nevin Özkan on 31.07.2024.
//
import Foundation
import Alamofire

final class MainVM {
    
    private var serviceManager = ServiceManager()
    private(set) var movies: [Movie] = []
    
    func fetchUpcomingMovies(completion: @escaping (Result<Void, Error>) -> Void) {
        serviceManager.fetchUpcomingMovies { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MovieResponse.self, from: data)
                    self.movies = response.results
                    completion(.success(()))
                } catch {
                    print("JSON decode error: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Network error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
