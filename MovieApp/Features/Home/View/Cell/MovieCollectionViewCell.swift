//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Nevin Özkan on 6.10.2024.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func prepareCell(with model: Movie) {
        movieTitle.text = model.title
        movieOverview.text = model.overview
        
        if let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + model.posterPath!) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
    }


}
