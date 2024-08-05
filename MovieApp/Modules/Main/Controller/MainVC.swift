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
    var viewModel = MainVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUpcomingMovies() {
            
        }
        
        viewModel.fetchNowPlayingMovies() {
    }
    }
    
}
