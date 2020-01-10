//
//  FavoriteArtistsViewController.swift
//  Artist
//
//  Created by Akan Akysh on 12/26/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import FirebaseAuth

class FavoriteArtistsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var TopNavigationItem: UINavigationItem!
    @IBOutlet var warningLabel: UILabel!
    
    var favouriteArtists = [Artist]()
    fileprivate var listener: AuthStateDidChangeListenerHandle!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authDidChangeListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(listener)
    }
    
    func authDidChangeListener() {
        listener = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user != nil {
                self.hideUIElements(false)
                
                if let data = UserDefaults.standard.value(forKey: user!.uid) as? Data {
                    self.favouriteArtists = try! PropertyListDecoder().decode(Array<Artist>.self, from: data)
                }
                self.tableView.reloadData()
                
            } else {
                self.favouriteArtists.removeAll()
                self.tableView.reloadData()
                self.hideUIElements(true)
                self.performSegue(withIdentifier: "GoToAuthorizationVC", sender: nil)
            }
        })
    }
    
    func hideUIElements(_ hide: Bool) {
        if hide {
            navigationItem.title = ""
        } else {
            self.navigationItem.title = "Favourite artists"
        }
        self.tableView.isHidden = hide
        self.warningLabel.isHidden = !hide
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToFavouriteArtistDescriptionVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let viewController = segue.destination as! FavouriteArtistDescriptionViewController
                viewController.artist = favouriteArtists[indexPath.row]
            }
        }
    }
}

// MARK: - table view delegate
extension FavoriteArtistsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouriteArtists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteArtistCell", for: indexPath)
        let artist = favouriteArtists[indexPath.row]
        cell.textLabel?.text = artist.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToFavouriteArtistDescriptionVC", sender: nil)
    }
}
