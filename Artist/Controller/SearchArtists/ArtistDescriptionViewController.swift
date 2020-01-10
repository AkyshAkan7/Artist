//
//  ArtistDescriptionViewController.swift
//  Artist
//
//  Created by Akan Akysh on 12/11/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import FirebaseAuth
import AlamofireImage
import SafariServices

class ArtistDescriptionViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistBornYearLabel: UILabel!
    @IBOutlet weak var artistGenreLabel: UILabel!
    @IBOutlet weak var artistWebsiteButton: UIButton!
    @IBOutlet weak var artistBiographyLabel: UILabel!
    @IBOutlet weak var showAndHideButton: UIButton!
    @IBOutlet weak var musicTableView: UITableView!
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    @IBOutlet weak var musicVideosCollectionView: UICollectionView!
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    
    
    var artist: Artist! = nil
    var isFavourite: Bool!
    var tracks = [Track]()
    var albums = [Album]()
    var musicVideos = [MusicVideo]()
    fileprivate var listener: AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadTracks()
        loadAlbums()
        loadMusicVideos()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if listener != nil {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
    
    @IBAction func favouriteButtonPressed(_ sender: Any) {
        listener = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user != nil {
                if self.isFavourite == true {
                    self.isFavourite = false
                    self.favouriteButton.image = UIImage(systemName: "star")
                    if let itemToRemoveIndex = FavouriteArtistManager.instance.favouriteArtits.firstIndex(of: self.artist) {
                        FavouriteArtistManager.instance.favouriteArtits.remove(at: itemToRemoveIndex)
                    }
                } else {
                    self.isFavourite = true
                    self.favouriteButton.image = UIImage(systemName: "star.fill")
                    if !FavouriteArtistManager.instance.favouriteArtits.contains(where: {$0.name == self.artist.name}) {
                        FavouriteArtistManager.instance.favouriteArtits.append(self.artist)
                    }
                }
                
                UserDefaults.standard.set(try? PropertyListEncoder().encode(FavouriteArtistManager.instance.favouriteArtits), forKey: user!.uid)
                
                UserDefaults.standard.set(self.isFavourite, forKey: self.artist.name)
                
            } else {
                let alert = UIAlertController(title: "Authorize to save artists to favourite", message: nil, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Authorize", style: .default, handler: { action in
                    self.performSegue(withIdentifier: "GoToAuthorizationVC", sender: nil)
                }))

                self.present(alert, animated: true)
            }
        })
        
    }
    
    
    @IBAction func showAndHideButtonTapped(_ sender: Any) {
        if showAndHideButton.titleLabel?.text == "read more" {
            showAndHideButton.setTitle("hide", for: .normal)
            artistBiographyLabel.numberOfLines = 0
        } else {
            showAndHideButton.setTitle("read more", for: .normal)
            artistBiographyLabel.numberOfLines = 6
        }
    }
    
    @IBAction func openWebsiteLink(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string: "https://" + artist.website)!)
        present(svc, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAlbumDescriptionVC" {
            if let indexPath = albumsCollectionView.indexPathsForSelectedItems?.first {
                let viewController = segue.destination as! AlbumDescriptionViewController
                viewController.album = albums[indexPath.row]
            }
        }
    }
    
    func setupView() {
        // setup navigation bar
        title = "Artist Description"
        
        // load image
        imageView.af_setImage(withURL: URL(string: artist.imageUrl)!)
        
        // setup ui elements with data
        if artist != nil {
            artistNameLabel.text = artist.name
            artistBornYearLabel.text = artist.bornYear
            artistGenreLabel.text = artist.genre
            artistWebsiteButton.setTitle(artist.website, for: .normal)
            artistBiographyLabel.text = artist.biography
            isFavourite = UserDefaults.standard.bool(forKey: artist.name)
        }
        
        if isFavourite == true {
            favouriteButton.image = UIImage(systemName: "star.fill")
        }
        
        if artistBiographyLabel.maxNumberOfLines() > 6 {
            artistBiographyLabel.numberOfLines = 6
        } else {
            showAndHideButton.isHidden = true
        }
        
        // setup table view
        let musicCellNib = UINib(nibName: "MusicTableViewCell", bundle: nil)
        musicTableView.register(musicCellNib, forCellReuseIdentifier: "trackCell")
        musicTableView.delegate = self
        musicTableView.dataSource = self
        musicTableView.reloadData()
        
        // setup albums collection view
        let albumCellNib = UINib(nibName: "AlbumCollectionViewCell", bundle: nil)
        albumsCollectionView.register(albumCellNib, forCellWithReuseIdentifier: "albumCell")
        albumsCollectionView.delegate = self
        albumsCollectionView.dataSource = self
        
        // setup music videos collection view
        let musicVideoCellNib = UINib(nibName: "MusicVideoCollectionViewCell", bundle: nil)
        musicVideosCollectionView.register(musicVideoCellNib, forCellWithReuseIdentifier: "musicVideoCell")
        musicVideosCollectionView.delegate = self
        musicVideosCollectionView.dataSource = self
    }
    
    func loadTracks() {
        ApiManager.loadArtistTracks(artistName: artist.name, onComplete: { (response) in
            self.tracks = response.track
            self.musicTableView.reloadData()
        }) {
            print("Error while parsing tracks")
        }
    }
    
    func loadAlbums() {
        ApiManager.loadArtistAlbums(artistName: artist.name, onComplete: { (response) in
            self.albums = response.album
            self.albumsCollectionView.reloadData()
        }) {
            print("Error while parsing albums")
        }
    }
    
    func loadMusicVideos() {
        ApiManager.loadMusicVideos(artistId: artist.id, onComplete: { (response) in
            self.musicVideos = response.mvids
            self.musicVideosCollectionView.reloadData()
        }, onError: {
            print("Error while parsing music videos")
        })
    }
    
}

// MARK: - table view delegate
extension ArtistDescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell") as! MusicTableViewCell
        cell.set(track: tracks[indexPath.row])
        
        return cell
    }
}

// MARK: - collection view delegate
extension ArtistDescriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == albumsCollectionView {
            return albums.count
        } else {
            return musicVideos.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == albumsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCollectionViewCell
            cell.set(album: albums[indexPath.row])
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicVideoCell", for: indexPath) as! MusicVideoCollectionViewCell
            cell.set(musicVideo: musicVideos[indexPath.row])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == albumsCollectionView {
            performSegue(withIdentifier: "goToAlbumDescriptionVC", sender: nil)
        } else {
            let svc = SFSafariViewController(url: URL(string: musicVideos[indexPath.row].videoUrl)!)
            present(svc, animated: true, completion: nil)
        }
    }
    
    
}


// MARK: - lable extension
extension UILabel {
    // function for checking number of lines of label
    func maxNumberOfLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font!], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}

