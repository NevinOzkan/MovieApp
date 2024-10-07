//
//  UpcomingCell.swift
//  MovieApp
//
//  Created by Nevin Özkan on 5.10.2024.
//

import UIKit
import SDWebImage

class UpcomingCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var owerviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var movie: Movie?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //Cell içinde görünecekler.
    func prepareCell(with model: Movie) {
        titleLabel.text = model.title
        owerviewLabel.text = model.overview
        dateLabel.text = formattedDate(from: model.releaseDate)
        
        if let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + model.posterPath!) {
            movieImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
            
            
        }
    }
    
    private func formattedDate(from dateString: String, fromFormat: String = "yyyy-MM-dd", toFormat: String = "dd.MM.yyyy") -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = fromFormat
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = toFormat
                return dateFormatter.string(from: date)
            } else {
                return "Geçersiz Tarih"
            }
        }
}


