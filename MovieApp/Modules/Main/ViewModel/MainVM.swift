//
//  MainVM.swift
//  MovieApp
//
//  Created by Nevin Özkan on 31.07.2024.
//
import Foundation

final class MainVM {
    
    private var serviceManager = ServiceManager()
    private(set) var movies: [Movie] = []
    
    func fetchUpcomingMovies(completion: @escaping () -> Void) {
        serviceManager.fetchUpcomingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    print(movies)
                    completion()
                }
                
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
            }
        }
    }
}
