//
//  AlbumDescriptionViewController.swift
//  Artist
//
//  Created by Akan Akysh on 12/14/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit

class AlbumDescriptionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumDescriptionLabel: UILabel!
    @IBOutlet weak var showAndHideButton: UIButton!
    
    var album: Album! = nil
    var albumTracks = [AlbumTrack]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadAlbumTracks()
    }
    
    @IBAction func showAndHideButtonPressed(_ sender: Any) {
        if showAndHideButton.titleLabel?.text == "read more" {
            showAndHideButton.setTitle("hide", for: .normal)
            albumDescriptionLabel.numberOfLines = 0
        } else {
            showAndHideButton.setTitle("read more", for: .normal)
            albumDescriptionLabel.numberOfLines = 6
        }
    }
    
    func setupView() {
        // setup ui elements with data
        if album != nil {
            albumNameLabel.text = album.artistName
            artistNameLabel.text = album.artistName
            albumDescriptionLabel.text = album.description
            if album.imageUrl != nil {
                albumImageView.af_setImage(withURL: URL(string: album.imageUrl!)!)
            }
        }
        
        if albumDescriptionLabel.maxNumberOfLines() > 6 {
            albumDescriptionLabel.numberOfLines = 6
        } else {
            showAndHideButton.isHidden = true
        }
        
        albumImageView.layer.cornerRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadAlbumTracks() {
        ApiManager.loadAlbumTracks(albumId: album.id, onComplete: { (response) in
            self.albumTracks = response.track
            self.tableView.reloadData()
        }) {
            print("Error while parsing album tracks")
        }
    }

}

extension AlbumDescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumTrackCell", for: indexPath)
        let track = albumTracks[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.text = track.name
        cell.detailTextLabel?.text = "\(Helpers.timeToMinutes(time: Int(track.duration)!)):\(Helpers.timeToSeconds(time: Int(track.duration)!)) min"
        
        return cell
    }
    
}
