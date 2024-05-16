//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Nevin Özkan on 13.05.2024.
//

import Foundation
import UIKit
import Alamofire

class HomeViewModel {
    
    var nowPlayingMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    var movies: [Movie] = []
    
    
    weak var tableView: UITableView?
    
    func fetchNowPlayingMovies() {
        NetworkManager.shared.fetchNowPlayingMovies { [weak self] result in
            switch result {
            case .success(let moviesResponse):
                self?.nowPlayingMovies = moviesResponse.results
                self?.updateTableView()
            case .failure(let error):
                print("Now Playing Movies Fetch Error: \(error)")
            }
        }
    }
    
    func fetchUpcomingMovies() {
        NetworkManager.shared.fetchUpcomingMovies { [weak self] result in
            switch result {
            case .success(let moviesResponse):
                self?.upcomingMovies = moviesResponse.results
                self?.updateTableView()
            case .failure(let error):
                print("Upcoming Movies Fetch Error: \(error)")
            }
        }
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.movies = self.nowPlayingMovies + self.upcomingMovies
            self.tableView?.reloadData()
        }
    }
}

