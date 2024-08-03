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
    
    func fetchUpcomingMovies() {
        let serviceManager = ServiceManager()
            serviceManager.fetchUpcomingMovies { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(MovieResponse.self, from: data)
                        self?.movies = response.results
                        DispatchQueue.main.async {
                            print(response.results)
                        }
                    } catch {
                        print("JSON decode error: \(error)")
                    }
                    
                case .failure(let error):
                    print("Failed to fetch movies: \(error)")
                }
            }
        }
    }
