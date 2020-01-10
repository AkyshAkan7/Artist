//
//  MusicTableViewCell.swift
//  Artist
//
//  Created by Akan Akysh on 12/13/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var backgroundTrackView: UIView!
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var trackGenreLabel: UILabel!
    @IBOutlet weak var trackMoodLabel: UILabel!
    @IBOutlet weak var trackDurationLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func set(track: Track) {
        trackNameLabel.text = track.name
        albumNameLabel.text = track.albumName
        trackGenreLabel.text = track.genre
        if let mood = track.mood {
            trackMoodLabel.text = mood
        }
        trackDurationLabel.text = "\(Helpers.timeToMinutes(time: Int(track.duration)!)):\(Helpers.timeToSeconds(time: Int(track.duration)!)) min"
        if track.imageUrl != nil {
            trackImageView.af_setImage(withURL: URL(string: track.imageUrl!)!)
        }
    }
    
    func setupView() {
        backgroundTrackView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        backgroundTrackView.layer.shadowOpacity = 1
        backgroundTrackView.layer.shadowRadius = 10
        backgroundTrackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        backgroundTrackView.layer.cornerRadius = 5
        trackImageView?.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
