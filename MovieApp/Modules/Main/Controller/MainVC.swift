//
//  MainVC.swift
//  MovieApp
//
//  Created by Nevin Özkan on 31.07.2024.
//

import UIKit
import Alamofire

class MainVC: UIViewController {
    
    private let viewModel = MainVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUpcomingMovies()
    }
    private func fetchUpcomingMovies() {
            viewModel.fetchUpcomingMovies { [weak self] result in
                switch result {
                case .success():
                    DispatchQueue.main.async {
                    
                    }
                case .failure(let error):
                    print("Failed to fetch movies: \(error)")
                }
            }
        }
}
