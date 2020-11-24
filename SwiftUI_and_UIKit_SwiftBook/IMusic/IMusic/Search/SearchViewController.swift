//
//  SearchViewController.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 11/22/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: class {
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
    
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var table: UITableView!
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic)?
    private var _searchViewModel = SearchViewModel(cells: [])
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = SearchInteractor()
        let presenter             = SearchPresenter()
        let router                = SearchRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        let nib = UINib(nibName: "TrackCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: TrackCell.reuseID)
    }
    
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        case .some:
            print("VC.some")
        case .displayTracks (let searchViewModel):
            self._searchViewModel = searchViewModel
            table.reloadData()
        }
    }
    
    
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._searchViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        
        let cellViewModel = _searchViewModel.cells[indexPath.row]
        cell.TrackImageView.image = #imageLiteral(resourceName: "library")
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84 
    }
}

extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        interactor?.makeRequest(request: Search.Model.Request.RequestType.getTracks(searchText: searchText))
    }
}

//extension SearchViewController {
//    func dismissKey()
//    {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(SearchViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard()
//    {
//        view.endEditing(true)
//    }
//}
