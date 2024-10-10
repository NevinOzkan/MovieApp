//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Nevin Özkan on 5.10.2024.
//

import Foundation

class HomeViewModel {
    
    enum CellType {
           case nowPlaying
           case upcoming
       }
       
    
    private let apiService = APIService()
    public var upcomingMovies: [Movie] = []
    public var nowPlayingMovies: [Movie] = []
    private var currentPage = 1
    private var isFetchingMovies = false

        public var cellTypes: [CellType] = []
        
    func fetchMovies(completion: @escaping () -> Void) {
        guard !isFetchingMovies else { return }
        isFetchingMovies = true

        let group = DispatchGroup()
        
        group.enter()
        fetchNowPlayingMovies { [weak self] in
            self?.cellTypes.append(.nowPlaying)
            print("Now playing movies fetched: \(self?.nowPlayingMovies.count ?? 0)") // Print kontrolü
            group.leave()
        }
        
        group.enter()
        fetchUpcomingMovies { [weak self] in
            self?.cellTypes.append(.upcoming)
            print("Upcoming movies fetched: \(self?.upcomingMovies.count ?? 0)") // Print kontrolü
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.isFetchingMovies = false
            completion()
        }
    }
    
    // Upcoming Movies için API çağrısı
        private func fetchUpcomingMovies(completion: @escaping () -> Void) {
            apiService.fetchUpcomingMovies(page: currentPage) { result in
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async { [weak self] in
                        self?.upcomingMovies.append(contentsOf: movies)
                        self?.currentPage += 1
                        completion()
                    }
                case .failure(let error):
                    print("Failed to fetch upcoming movies: \(error)")
                    completion()
                }
            }
        }
        
        // Now Playing Movies için API çağrısı
        private func fetchNowPlayingMovies(completion: @escaping () -> Void) {
            apiService.fetchNowPlayingMovies(page: currentPage) { result in
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async { [weak self] in
                        self?.nowPlayingMovies.append(contentsOf: movies)
                        self?.currentPage += 1
                        completion()
                    }
                case .failure(let error):
                    print("Failed to fetch now playing movies: \(error)")
                    completion()
                }
            }
        }
    }
