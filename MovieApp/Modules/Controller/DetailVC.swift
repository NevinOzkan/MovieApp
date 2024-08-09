//
//  DetailVC.swift
//  MovieApp
//
//  Created by Nevin Özkan on 5.08.2024.
//

import UIKit

class DetailVC: UIViewController {
    
   
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var imdbImage: UIImageView!
    @IBOutlet weak var movieDetail: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
            guard let movie = movie else { return }
            
            movieTitle.text = movie.title
            movieDetail.text = movie.releaseDate
            movieDescription.text = movie.overview
            
            if let posterPath = movie.posterPath, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
                movieImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
            }
        }
}
   
