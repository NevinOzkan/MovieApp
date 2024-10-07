//
//  DetailVC.swift
//  MovieApp
//
//  Created by Nevin Özkan on 7.10.2024.
//

import UIKit

class DetailVC: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    
    var movie: Movie?
    var movieID: Int?
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func ImdbButton(_ sender: Any) {
    }
    
}
