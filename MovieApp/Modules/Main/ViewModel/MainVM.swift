//
//  MainVM.swift
//  MovieApp
//
//  Created by Nevin Özkan on 31.07.2024.
//
import Foundation

final class MainVM {
    
    enum CellType {
        case nowPlaying
        case upcoming
    }
    
    private var serviceManager = ServiceManager()
    private(set) var upcomingMovies: [Movie] = []
    private(set) var nowPlayingMovies: [Movie] = []
    var cellTypes: [CellType] = []
    
    
    // Filmleri çekip ve güncelledim
    func fetchUpcomingMovies(completion: @escaping () -> Void) {
        serviceManager.fetchUpcomingMovies { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    upcomingMovies = movies
                    cellTypes.append(.upcoming)
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
   
