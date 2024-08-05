//
//  MainVM.swift
//  MovieApp
//
//  Created by Nevin Özkan on 31.07.2024.
//
import Foundation

final class MainVM {
    
    private var serviceManager = ServiceManager()
    private(set) var upcomingMovies: [Movie] = []
    private(set) var nowPlayingMovies: [Movie] = []
    
    func fetchUpcomingMovies(completion: @escaping () -> Void) {
        serviceManager.fetchUpcomingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.upcomingMovies = movies
                    print(movies)
                    completion()
                }
                
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
            }
        }
    }
    
    func fetchNowPlayingMovies(completion: @escaping () -> Void) {
            serviceManager.fetchNowPlayingMovies { [weak self] result in
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        self?.nowPlayingMovies = movies
                        print(movies)
                        completion()
                    }
                case .failure(let error):
                    print("Failed to fetch movies: \(error)")
                }
            }
        }
    }
   
