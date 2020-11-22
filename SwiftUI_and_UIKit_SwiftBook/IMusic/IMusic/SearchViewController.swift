//
//  SearchViewController.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 11/21/20.
//

import UIKit
import Alamofire

struct TrackModel {
    var trackName: String
    var artistName: String
    
}

class SearchViewController : UITableViewController {
    
    private var networkService = NetworkService()
    private var timer: Timer?
    
    var tracks = [Track]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpSearchBar()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let currTrack = tracks[indexPath.row]
        cell.textLabel?.text = "\(currTrack.trackName)\n\(currTrack.artistName)"
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = #imageLiteral(resourceName: "library")
        return cell
    }
    
    // Устанавливаем поисковый бар сверху в searchController
    private func setUpSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self // 
    }
    
}

extension SearchViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { _ in
            self.networkService.fetchTracks(for: searchText) { [weak self] (search_results) in
                self?.tracks = search_results?.results ?? []
                self?.tableView.reloadData()
            }
        })
        
    }
    
}
