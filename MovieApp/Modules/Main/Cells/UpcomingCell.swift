//
//  UpcomingCell.swift
//  MovieApp
//
//  Created by Nevin Özkan on 6.08.2024.
//

import UIKit

final class UpcomingCell: UITableViewCell {
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    @IBOutlet private weak var movieDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepareCell(with model: Movie) {
        movieTitleLabel.text = model.title
        movieDateLabel.text = model.releaseDate
        movieDescriptionLabel.text = model.overview
        
    }
}
