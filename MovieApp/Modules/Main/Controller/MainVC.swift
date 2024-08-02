//
//  MainVC.swift
//  MovieApp
//
//  Created by Nevin Özkan on 31.07.2024.
//

import UIKit
import Alamofire

class MainVC: UIViewController {
    
    var movies: [Movie] = []

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
