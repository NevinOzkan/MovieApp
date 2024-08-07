//
//  MainVC.swift
//  MovieApp
//
//  Created by Nevin Özkan on 31.07.2024.
//

import UIKit

final class MainVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel = MainVM()
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        fetchMovies()
    }
    
    private func registerCells() {
        let upCominCellName = String(describing: UpcomingCell.self)
        let upComingCellNib = UINib(nibName: upCominCellName, bundle: .main)
        tableView.register(upComingCellNib, forCellReuseIdentifier: upCominCellName)
    }
    
    private func fetchMovies() {
        viewModel.fetchUpcomingMovies() { [weak self] in
            guard let self else { return }
            tableView.reloadData()
        }
        
        viewModel.fetchNowPlayingMovies() {
            
        }
    }
    

}

extension MainVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.cellTypes[section] {
        case .nowPlaying: return 1
        case .upcoming: return viewModel.upcomingMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cellTypes[indexPath.section] {
        case .nowPlaying:
            return UITableViewCell()
        case .upcoming:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UpcomingCell.self)) as? UpcomingCell {
                cell.prepareCell(with: viewModel.upcomingMovies[indexPath.row])
                return cell
            }
            return UITableViewCell()
        }
    }
}


