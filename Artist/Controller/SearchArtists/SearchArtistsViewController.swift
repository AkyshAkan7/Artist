//
//  ViewController.swift
//  Artist
//
//  Created by Akan Akysh on 12/10/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit

class SearchArtistsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearchBarEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var artists = [Artist]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        // setup search bar
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search artists"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //setup table view
        tableView.delegate = self
        tableView.dataSource = self
        hideTableView(hide: true)
    }
    
    func hideTableView(hide: Bool) {
        if hide{
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToArtistDescriptionVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let viewController = segue.destination as! ArtistDescriptionViewController
                viewController.artist = artists[indexPath.row]
            }
        }
    }

}


// MARK: - search bar delegate
extension SearchArtistsViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        artists.removeAll()
        hideTableView(hide: false)
        guard let textToSearch = searchController.searchBar.text, !textToSearch.isEmpty else {
            return
        }
        
        ApiManager.loadArtists(artistName: textToSearch, onComplete: { (response) in
            self.artists = response.artists
        }) {
            print("Error while parsing artist")
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        artists.removeAll()
        hideTableView(hide: true)
    }
}


// MARK: - table view delegate
extension SearchArtistsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let artist = artists[indexPath.row]
        cell.textLabel?.text = artist.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToArtistDescriptionVC", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

