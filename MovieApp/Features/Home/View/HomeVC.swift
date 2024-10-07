//
//  HomeVC.swift
//  MovieApp
//
//  Created by Nevin Özkan on 5.10.2024.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var viewModel = HomeViewModel()
    var movies: [Movie] = []
    var currentPage = 1
    private var upcomingMovies = [Movie]()
    private var nowPlayingMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
               
        tableView.delegate = self
        tableView.dataSource = self
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self

        if let layout = sliderCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
               layout.scrollDirection = .horizontal // Yatay kaydırma
               layout.minimumLineSpacing = 0 // Hücreler arasındaki boşluk sıfır
               layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 250) // Hücre boyutu
           }
        
        sliderCollectionView.isPagingEnabled = true // Sayfaları geçiş yaparken tam kapsama

          
        
        fetchUpcomingMovies()
        fetchNowPlayingMovies()
        
        pageControl.numberOfPages = nowPlayingMovies.count
        pageControl.currentPage = 0
       
        
    }
    
    private func fetchUpcomingMovies() {
        viewModel.fetchUpcomingMovies { result in
            switch result {
            case .success(let movies):
                print("Upcoming movies: \(movies)")
                self.upcomingMovies = movies // Güncelleme
                DispatchQueue.main.async {
                    self.tableView.reloadData() // Table view'i güncelle
                }
            case .failure(let error):
                print("Error fetching upcoming movies: \(error)")
            }
        }
    }
    
    private func fetchNowPlayingMovies() {
        viewModel.fetchNowPlayingMovies { result in
            switch result {
            case .success(let movies):
                print("Now playing movies: \(movies)")
                self.nowPlayingMovies = movies
                DispatchQueue.main.async {
                    self.sliderCollectionView.reloadData()
                    self.pageControl.numberOfPages = self.nowPlayingMovies.count // Sayfa sayısını güncelle
                }
            case .failure(let error):
                print("Error fetching now playing movies: \(error)")
            }
        }
    }
    //tableviewda kullanmak için kaydettim.
    private func registerCells() {
        let nib = UINib(nibName: "UpcomingCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UpcomingCell")
        
        let collectionNib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        sliderCollectionView.register(collectionNib, forCellWithReuseIdentifier: "MovieCollectionViewCell")  // Bu satırı kontrol et
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingCell", for: indexPath) as? UpcomingCell else {
            return UITableViewCell()
        }
        
        // upcomingMovies dizinizden ilgili filmi al ve hücreye aktar
        let movie = upcomingMovies[indexPath.row]
        cell.prepareCell(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let movie = upcomingMovies[indexPath.row]
        
        let vc = DetailVC(nibName: "DetailVC", bundle: Bundle.main)
        vc.movieID = movie.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Hücreyi dequeue işlemi ile oluşturuyoruz
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Error dequeuing cell: MovieCollectionViewCell")
        }
        
        // Şu an oynayan film dizisinden ilgili filmi alıyoruz
        let movie = nowPlayingMovies[indexPath.row]
        
        // Hücreyi filme göre hazırlıyoruz
        cell.prepareCell(with: movie)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Page Control'ü güncelle
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = pageIndex
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        pageControl.currentPage = currentPage
    }

}
