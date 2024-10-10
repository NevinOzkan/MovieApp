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
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
        var viewModel = HomeViewModel()
        var currentPage = 1
        private var isLoading = false // Yükleniyor durumu
        private var upcomingMovies = [Movie]()
        private var nowPlayingMovies = [Movie]()
       private let refreshControl = UIRefreshControl()
            
        
        override func viewDidLoad() {
            super.viewDidLoad()
            registerCells()
            fetchMovies()
                   
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

            pageControl.numberOfPages = nowPlayingMovies.count
            pageControl.currentPage = 0
           
    
            
            // Pull to refresh için refreshControl ekleyin
                tableView.refreshControl = refreshControl
                refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            
        }
    
    @objc private func refreshData() {
        currentPage = 1
        viewModel.upcomingMovies.removeAll()
        viewModel.nowPlayingMovies.removeAll()
        fetchMovies()
    }

    private func fetchMovies() {
        activity.isHidden = false
        activity.startAnimating()

        // Verileri çekmeden önce mevcut verileri temizleyin (özellikle pull-to-refresh sırasında)
        self.upcomingMovies.removeAll()
        self.nowPlayingMovies.removeAll()
        
        viewModel.fetchMovies { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.activity.stopAnimating()
                self.activity.isHidden = true

                // Verileri güncelle
                self.upcomingMovies = self.viewModel.upcomingMovies
                self.nowPlayingMovies = self.viewModel.nowPlayingMovies
                
                // Eğer veriler boşsa hata mesajı gösterin veya başka bir işlem yapın
                if self.upcomingMovies.isEmpty && self.nowPlayingMovies.isEmpty {
                    print("Veri alınamadı") // Hata mesajını konsola yazdır
                    // Burada kullanıcıya bir uyarı verebilirsiniz.
                } else {
                    self.pageControl.numberOfPages = self.nowPlayingMovies.count
                    
                    // TableView ve CollectionView'ı güncelleyin
                    self.tableView.reloadData()
                    self.sliderCollectionView.reloadData()
                }

                // Yenileme kontrolünü durdur
                self.refreshControl.endRefreshing() // Burayı doğru konumda çağırın
            }
        }
    }
    
    private func fetchMoreMovies() {
        // Sayfa numarasını kontrol edin, daha fazla veri çekip çekmeyeceğinizi belirleyin
        if isLoading { return } // Eğer yükleniyorsa çık
        isLoading = true // Yükleme başladığını belirt
        
        viewModel.fetchMovies { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false // Yükleme tamamlandı
                self.tableView.reloadData()
                self.sliderCollectionView.reloadData()
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
            
            let movie = upcomingMovies[indexPath.row]
            cell.prepareCell(with: movie)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 140
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height
            
            if scrollView == tableView && offsetY > contentHeight - height {
                // TableView'ın altına ulaşıldı
                fetchMoreMovies()
            }
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
                fatalError("Error dequeuing cell: MovieCollectionViewCell")
            }
            
            let movie = nowPlayingMovies[indexPath.row]
            cell.prepareCell(with: movie)
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = pageIndex
        }
    

    }
