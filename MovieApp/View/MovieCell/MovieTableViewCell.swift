//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Nevin Özkan on 10.05.2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movie: Movie?
    weak var parentViewController: UIViewController?
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var buttonTapped: UIButton!
    
    var buttonIcon: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        movieImageView.layer.cornerRadius = movieImageView.frame.height / 4 //  görüntüyü oval yapar
        }
    
    @IBAction func buttonTapped(_ sender: Any) {
        print("Button is tapped!")
               guard let movie = movie else {
                   return
               }
               
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let detailVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
               
               detailVC.movie = movie
               
               // Yönlendirme işlemi
               if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                   navigationController.pushViewController(detailVC, animated: true)
               }
           }
       }
