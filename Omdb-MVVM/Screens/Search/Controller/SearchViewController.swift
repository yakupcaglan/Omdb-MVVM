//
//  SearchViewController.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit
import SnapKit

final class SearchViewController: BaseViewController<SearchView> {
    
    // MARK: - Properties
    
    private var tableView: UITableView { layoutableView.tableView }
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        return indicator
    }()
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    private let viewModel: SearchViewModelProtocol
    
    public required init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        navigationItem.largeTitleDisplayMode = .automatic
        view.backgroundColor = AppStyle.Colors.mainBackgroundColor

        layoutableView.set(dataSource: self, delegate: self)
        
        viewModel.delegate = self
        
        setupSearchBar()
        setupIndicator()
    }
    
    // MARK:- Helpers
    
    private func setupSearchBar() {
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search movie or series"
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.returnKeyType = .search
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.textColor = .white
        } else {
            // Fallback on earlier versions
        }
        searchController.obscuresBackgroundDuringPresentation = false
  
    }
    
    private func setupIndicator() {
        view.add(indicator)
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK:- Selectors
    
    @objc private func reload(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else { return }
        viewModel.searchMovies(with: searchText)
    }
}

// MARK:- UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.text!.isEmpty ? indicator.stopAnimating() : indicator.startAnimating()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: searchBar)
        perform(#selector(reload), with: searchBar, afterDelay: 0.5)

    }
}

// MARK:- SearchViewModelDelegate

extension SearchViewController: SearchViewModelDelegate {
    func setLoading(loading: Bool) {
        DispatchQueue.main.async {
            loading ? self.indicator.startAnimating() : self.indicator.stopAnimating()
        }
    }
    func searchMoviesDidChange() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK:- UITableViewDelegate Methods

extension SearchViewController: UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        if viewModel.numberOfitems == 0 {
            tableView.backgroundView = SearchInfoView()
        }
        
        
        return viewModel.numberOfitems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SearchCell
        
        cell.item = viewModel.item(by: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height * 0.2
    }
}

// MARK:- UITableViewDataSource Methods

extension SearchViewController: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let item = viewModel.item(by: indexPath.row) else { return }
    
        let container = DependencyContainer()
        let detailViewController = container.makeDetailViewController(movieID: item.imdbID)
        
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
