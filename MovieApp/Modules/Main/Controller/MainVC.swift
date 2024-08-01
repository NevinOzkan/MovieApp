//
//  MainVC.swift
//  MovieApp
//
//  Created by Nevin Özkan on 31.07.2024.
//

import UIKit

class MainVC: UIViewController {
    
    private var movies: [Movie] = []
    private let serviceManager = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUpcomingMovies()
    }
    
    private func fetchUpcomingMovies() {
        let serviceManager = ServiceManager()
        serviceManager.fetchUpcomingMovies { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MovieResponse.self, from: data)
                    self?.movies = response.results
                    DispatchQueue.main.async {
                        
                    }
                } catch {
                    print("JSON decode error: \(error)")
                }
            case .failure(let error):
                print("Network error: \(error)")
            }
        }
    }
}
