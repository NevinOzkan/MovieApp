//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Nevin Özkan on 10.05.2024.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, MovieTableViewCellDelegate {
    
    func didTapButtonIcon(with movie: Movie?) {
        guard let movie = movie else {
                   return
               }
        
        let detailVC = DetailViewController()
                detailVC.movie = movie
                navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    var movies: [Movie] = []
    var collectionView: UICollectionView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        // Her hücre için farklı bir resim belirleme
           let imageName = imageNames[indexPath.row % imageNames.count] // Dizinin sınırlarını aşmak için % operatörü kullanılır
           cell.movieImageView.image = UIImage(named: imageName)
        
        
        // UIButton yerine Bool türünde bir özellik
        var buttonTapped: Bool = false {
            didSet {
                // buttonTapped özelliği değiştiğinde yapılacak işlemler burada
                if buttonTapped {
                    // Butona tıklandığında yapılacak işlemler burada
                } else {
                    // Butona tıklanmadığında yapılacak işlemler burada
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    
    
    
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imageNames = ["GreenBokk.jpg", "TheGreatBeauty.jpg", "ThereWillBeBlood.jpg", "AmericanBeauty.jpg"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Üst Scroll View konfigürasyonu
        imageScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(imageNames.count), height: imageView.frame.maxY)
        let imageWidth = imageScrollView.frame.width // Ekran genişliği kadar olacak
        imageScrollView.isPagingEnabled = true
        imageScrollView.isPagingEnabled = true
        imageScrollView.delegate = self
        
        // Image view içeriğini yükleme
        for (index, imageName) in imageNames.enumerated() {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: view.frame.width * CGFloat(index), y: 0, width: view.frame.width, height: self.imageView.frame.height)
            imageScrollView.addSubview(imageView)
        }
        
        
        // Alt Scroll View'in içindeki TableView'ın boyutunu ayarlama
        tableView.frame = CGRect(x: 0, y: 0, width: tableScrollView.frame.width, height: tableScrollView.frame.height)
        
        
        // TableView konfigürasyonu
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        
        // Alt Scroll View içeriğinin boyutunu ayarlayalım
        tableScrollView.contentSize = tableView.frame.size
        tableScrollView.addSubview(tableView)
    }
    
   
    
    private func setupScrollView() {
        var contentWidth: CGFloat = 0
        
        for (index, imageName) in imageNames.enumerated() {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFill
            let xPosition = self.view.frame.width * CGFloat(index)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.imageScrollView.frame.height)
            imageScrollView.addSubview(imageView)
            contentWidth += self.view.frame.width // Görüntülerin genişliğini ekleyin
        }
        
        imageScrollView.contentSize = CGSize(width: contentWidth, height: imageScrollView.frame.size.height)
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageControl.currentPage = pageIndex
    }
    
    
}
