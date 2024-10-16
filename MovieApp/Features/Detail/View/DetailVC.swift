//
//  DetailVC.swift
//  MovieApp
//
//  Created by Nevin Özkan on 7.10.2024.
//

import UIKit

class DetailVC: UIViewController, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    
   
    var movieID: Int?
    private var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        setupUI()
                guard let movieID = movieID else {
                    showAlert(message: "Film ID bulunamadı.")
                    return
                }
                
        displayMovieDetail(movieID: movieID)
    }
    
//Ekran kaydırılması.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    private func displayMovieDetail(movieID: Int) {
        viewModel.fetchMovieDetails(movieID: movieID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.setupUI()
                case .failure(let error):
                    self?.showAlert(message: "Hata: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func setupUI() {
        guard let movie = viewModel.movie else { return }
        
        titleLabel.text = movie.title
        dateLabel.text = formatDateString(movie.releaseDate)
        overviewTextView.text = movie.overview
        
        let ratingText = "\(movie.voteAverage)/10"
        let attributedString = NSMutableAttributedString(string: ratingText)
        let range = (ratingText as NSString).range(of: "/10")
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: range)
        voteLabel.attributedText = attributedString
        
        if let posterPath = movie.posterPath, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder")) { [weak self] (_, error, _, _) in
                }
            }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func formatDateString(_ dateString: String, fromFormat: String = "yyyy-MM-dd", toFormat: String = "dd.MM.yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: date)
        } else {
            return dateString
        }
    }
    
    @IBAction func ImdbButton(_ sender: Any) {
        print(viewModel.movie?.imdbID as Any)
        guard let imdbID = viewModel.movie?.imdbID,
              let url = URL(string: "https://www.imdb.com/title/" + imdbID) else {
            print("IMDb ID geçersiz.")
            return
        }
        UIApplication.shared.open(url)
    }
    
}
