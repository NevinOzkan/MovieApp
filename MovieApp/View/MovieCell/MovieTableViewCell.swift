//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Nevin Özkan on 10.05.2024.
//

import UIKit

protocol MovieTableViewCellDelegate: AnyObject {
    func didTapButtonIcon(with movie: Movie?)
}


class MovieTableViewCell: UITableViewCell {
    
    var movie: Movie?
    weak var delegate: MovieTableViewCellDelegate?
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var buttonTapped: UIButton!
    
    var buttonIcon: (() -> Void)? // buttonTapped closure'u
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func buttonIcon(_ sender: Any) {
        print("Button tapped!")
        guard let movie = movie else {
            return
        }
        delegate?.didTapButtonIcon(with: movie)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        
        detailVC.movie = movie
        
        // Yönlendirme işlemi
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.pushViewController(detailVC, animated: true)
        }
    }
    
    
    
}
