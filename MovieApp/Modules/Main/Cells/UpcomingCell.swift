//
//  UpcomingCell.swift
//  MovieApp
//
//  Created by Nevin Özkan on 6.08.2024.
//

import UIKit
import SDWebImage

final class UpcomingCell: UITableViewCell {
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    @IBOutlet private weak var movieDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func prepareCell(with model: Movie) {
        movieTitleLabel.text = model.title
        movieDateLabel.text = model.releaseDate
        movieDescriptionLabel.text = model.overview
        // Resmi yükler.
        if let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + model.posterPath!) {
                   movieImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
           
               }
    }
}
